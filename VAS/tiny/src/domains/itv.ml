(* Template to write your own non relational abstract domain. *)

(* To implement your own non relational abstract domain,
 * first give the type of its elements, *)
type t =
  | Bottom
  | Itv of int option * int option (* None rpz un ±∞ *)

(* a printing function (useful for debuging), *)
let fprint ff = function
  | Bottom -> Format.fprintf ff "⊥"
  | Itv (None, Some sup) -> Format.fprintf ff "[-∞, %d]" sup
  | Itv (Some inf, None) -> Format.fprintf ff "[%d, +∞]" inf
  | Itv (Some inf, Some sup) -> Format.fprintf ff "[%d, %d]" inf sup
  | Itv (None, None) -> Format.fprintf ff "[-∞, +∞]"
;;

(* a <= b avec None = -∞ *)
let ( <=- ) a b =
  match a, b with
  | None, _ -> true
  | _, None -> false
  | Some na, Some nb -> na <= nb
;;

(* a <= b avec None +∞ *)
let ( <=+ ) a b =
  match a, b with
  | _, None -> true
  | None, _ -> false
  | Some na, Some nb -> na <= nb
;;

(* a + b sur les entiers + infinis *)
let ( + ) a b =
  match a, b with
  | None, _ -> None
  | _, None -> None
  | Some a, Some b -> Some (a + b)
;;

(* a - b sur les entiers + infinis *)
let ( - ) a b =
  match a, b with
  | None, _ -> None
  | _, None -> None
  | Some n1, Some n2 -> Some (n1 - n2)
;;

let mk_itv x y =
  match x, y with
  | None, _ -> Itv (x, y)
  | _, None -> Itv (x, y)
  | Some a, Some b -> if a <= b then Itv (x, y) else Bottom
;;

(* the order of the lattice, aka x ⊆ y *)
let order x y =
  match x, y with
  | Bottom, _ -> true
  | _, Bottom -> false
  | Itv (ax, bx), Itv (ay, by) -> ay <=- ax && bx <=+ by
;;

(* and infimums of the lattice. *)
let top = Itv (None, None)
let bottom = Bottom

(* All the functions below are safe overapproximations.
 * You can keep them as this in a first implementation,
 * then refine them only when you need it to improve
 * the precision of your analyses. *)

let join x y =
  match x, y with
  | Bottom, _ -> y
  | _, Bottom -> x
  | Itv (ax, bx), Itv (ay, by) ->
    let min_a = if ax <=- ay then ax else ay
    and max_b = if bx <=+ by then by else bx in
    mk_itv min_a max_b
;;

let meet x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Itv (ax, bx), Itv (ay, by) ->
    let max_a = if ax <=- ay then ay else ax
    and min_b = if bx <=+ by then by else bx in
    mk_itv max_a min_b
;;

let widening = join
(* Ok, maybe you'll need to implement this one if your
 * lattice has infinite ascending chains and you want
 * your analyses to terminate. *)

let sem_itv n1 n2 = mk_itv (Some n1) (Some n2)

let sem_plus x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Itv (ax, bx), Itv (ay, by) -> Itv (ax + ay, bx + by)
;;

let sem_minus x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Itv (ax, bx), Itv (ay, by) -> mk_itv (ax - by) (bx - ay)
;;

(* cas sans bottom *)
let sem_times_aux ax bx ay by =
  match (ax, bx), (ay, by) with
  (* un des intervalles vaut {0} *)
  | (Some 0, Some 0), (_, _) | (_, _), (Some 0, Some 0) -> Itv (Some 0, Some 0)
  (* un des intervalles vaut [-∞; +∞] *)
  | (None, None), (_, _) | (_, _), (None, None) -> Itv (None, None)
  (* bornes inf explicites *)
  | (Some ax, None), (Some ay, None) ->
    let borne_inf =
      if ax < 0 || ay < 0 then
        None (* +∞ * truc positif = -∞ *)
      else
        Some (ax * ay)
    in
    mk_itv borne_inf None
  (* bornes sup explicites *)
  | (None, Some bx), (None, Some by) ->
    let borne_inf =
      if bx > 0 || by > 0 then
        None (* -∞ * truc positif = -∞ *)
      else
        Some (bx * by)
    in
    mk_itv borne_inf None
  (* bornes croisées 1 *)
  | (None, Some bx), (Some ay, None) ->
    let borne_sup =
      if bx > 0 || ay < 0 then
        None (* ±∞ * truc de l'autre signe = +∞ *)
      else
        Some (bx * ay)
    in
    mk_itv None borne_sup
  (* bornes croisées 2 *)
  | (Some ax, None), (None, Some by) ->
    let borne_sup =
      if ax < 0 || by > 0 then
        None
      else
        Some (ax * by)
    in
    mk_itv None borne_sup
  (* 3 explicites 1 *)
  | (None, Some bx), (Some ay, Some by) ->
    let borne_inf =
      if ay > 0 || by > 0 then
        None
      else
        Some (min (bx * ay) (bx * by))
    and borne_sup =
      if ay < 0 || by < 0 then
        None
      else
        Some (max (bx * ay) (bx * by))
    in
    mk_itv borne_inf borne_sup
  (* 3 explicites 2 *)
  | (Some ax, None), (Some ay, Some by) ->
    let borne_inf =
      if ay < 0 || by < 0 then
        None
      else
        Some (min (ax * ay) (ax * by))
    and borne_sup =
      if ay > 0 || by > 0 then
        None
      else
        Some (max (ax * ay) (ax * by))
    in
    mk_itv borne_inf borne_sup
  (* 3 explicites 3 *)
  | (Some ax, Some bx), (None, Some by) ->
    let borne_inf =
      if ax > 0 || bx > 0 then
        None
      else
        Some (min (ax * by) (bx * by))
    and borne_sup =
      if ax < 0 || by < 0 then
        None
      else
        Some (max (ax * by) (bx * by))
    in
    mk_itv borne_inf borne_sup
  (* 3 explicites 4 *)
  | (Some ax, Some bx), (Some ay, None) ->
    let borne_inf =
      if ax < 0 || bx < 0 then
        None
      else
        Some (min (ax * ay) (bx * ay))
    and borne_sup =
      if ax > 0 || ay > 0 then
        None
      else
        Some (max (ax * ay) (bx * ay))
    in
    mk_itv borne_inf borne_sup
  (* Les deux intervalles sont explicites *)
  | (Some ax, Some bx), (Some ay, Some by) ->
    let all_products = [ ax * ay; ax * by; bx * ay; bx * by ] in
    let borne_inf = List.fold_right min all_products ax * ay in
    let borne_sup = List.fold_right max all_products ax * ay in
    mk_itv (Some borne_inf) (Some borne_sup)
;;

let sem_times x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Itv (ax, bx), Itv (ay, by) -> sem_times_aux ax bx ay by
;;

let sem_inv x =
  match x with
  | Bottom -> Bottom
  (* TODO *)
  (* let contains0 = a <=- Some 0 && Some 0 <=+ b in
      if not contains0 then None else None *)
  | Itv (a, b) -> Bottom
;;

let sem_div x y = sem_times x (sem_inv y)

let sem_guard = function
  | t -> t
;;

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y
