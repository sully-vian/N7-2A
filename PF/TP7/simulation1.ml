open Flux

(* le type des états de la forme (x, y), (dx, dy)  *)
(* i.e. position (x, y) et vitesse (dx, dy)        *)
type etat = (float * float) * (float * float)

(* Parametres globaux de la simulation      *)
(* dt : pas de temps                        *)
(* box_x : paire d'abscisses (xmin, xmax)   *)
(* box_y : paire d'ordonnees (ymin, ymax)   *)
module type Frame = sig
  val dt : float
  val box_x : float * float
  val box_y : float * float
end

(* Fonction qui intègre/somme les valeurs successives du flux *)
(* avec un pas de temps dt et une valeur initiale nulle, i.e. *)
(* acc_0 = 0; acc_{i+1} = acc_{i} + dt * flux_{i}             *)
(* paramètres:                                                *)
(* dt : float                                                 *)
(* flux : (float * float) Flux.t                              *)
let integre dt flux =
  (* valeur initiale de l'intégrateur *)
  let init = 0., 0. in
  (* fonction auxiliaire de calcul de acc_{i} + dt * flux_{i} *)
  let iter (acc1, acc2) (flux1, flux2) = acc1 +. (dt *. flux1), acc2 +. (dt *. flux2) in
  (* définition récursive du flux acc *)
  let rec acc = Tick (lazy (Some (init, Flux.map2 iter acc flux))) in
  acc
;;

module type FramedSimulation = functor (F : Frame) -> sig
  val g : float
  val run : etat -> etat flux
end

(* Module du modèle dynamique d'une balle en 2D.               *)
(* A partir d'un état initial, run produit le flux des états   *)
(* successifs de la balle, qui pourra être affiché             *)
module FreeFall : FramedSimulation =
functor
  (F : Frame)
  ->
  struct
    let g = 9.81 (* champs gravitationnel terrestre *)

    let run : etat -> etat flux =
      fun ((px0, py0), (vx0, vy0)) ->
      let acc = Flux.constant (0., -.g) in
      let vit = Flux.map (fun (vx, vy) -> vx +. vx0, vy +. vy0) (integre F.dt acc) in
      let pos = Flux.map (fun (px, py) -> px +. px0, py +. py0) (integre F.dt vit) in
      Flux.map2 (fun p v -> p, v) pos vit
    ;;
  end
