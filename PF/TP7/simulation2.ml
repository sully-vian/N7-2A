open Flux
open Simulation1

(* Exercice 4 *)
(* Détecte une collision en x *)

module Bouncing : FramedSimulation =
functor
  (F : Frame)
  ->
  struct
    let rec unless : 'a Flux.t -> ('a -> bool) -> ('a -> 'a Flux.t) -> 'a Flux.t =
      fun flux cond f_flux ->
      Tick
        (lazy
          (match Flux.uncons flux with
           | None -> None
           | Some (t, q) ->
             if cond t then Some (t, f_flux t) else Some (t, unless q cond f_flux)))
    ;;

    let contact_x : float -> float -> bool =
      fun x dx -> (x < fst F.box_x && dx < 0.) || (x > snd F.box_x && dx > 0.)
    ;;

    (* Calcule dx après le rebond ssi il y a contact *)
    let rebond_x : float -> float -> float =
      fun x dx -> if contact_x x dx then -.dx else dx
    ;;

    (* Détecte une collision en y *)
    let contact_y : float -> float -> bool =
      fun y dy -> (y < fst F.box_y && dy < 0.) || (y > snd F.box_y && dy > 0.)
    ;;

    (* Calcule dy après le rebond ssi il y a contact *)
    let rebond_y : float -> float -> float =
      fun y dy -> if contact_y y dy then -.dy else dy
    ;;

    let g = 1000. (* champs gravitationnel terrestre *)

    let contact : etat -> bool =
      fun ((px, py), (dx, dy)) -> contact_x px dx || contact_y py dy
    ;;

    let rebonds : etat -> etat =
      fun ((px0, py0), (vx0, vy0)) -> (px0, py0), (rebond_x px0 vx0, rebond_y py0 vy0)
    ;;

    let rec run : etat -> etat Flux.t =
      fun ((px0, py0), (vx0, vy0)) ->
      let acc = Flux.constant (0., -.g) in
      let vit = Flux.map (fun (vx, vy) -> vx +. vx0, vy +. vy0) (integre F.dt acc) in
      let pos = Flux.map (fun (px, py) -> px +. px0, py +. py0) (integre F.dt vit) in
      unless (Flux.map2 (fun p v -> p, v) pos vit) contact (fun e -> run (rebonds e))
    ;;
  end
