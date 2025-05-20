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

let sem_times x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Itv (ax, bx), Itv (ay, by) ->
    (match ax, bx, ay, by with
     | Some 0, Some 0, _, _ -> Itv (Some 0, Some 0)
     | _, _, Some 0, Some 0 -> Itv (Some 0, Some 0)
     | None, None, _, _ -> Itv (None, None)
     | _, _, None, None -> Itv (None, None)
     | _ -> failwith "pas implémenté gros malin")
;;

let sem_div x y = top

let sem_guard = function
  | t -> t
;;

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y
