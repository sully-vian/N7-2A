(* Template to write your own non relational abstract domain. *)

(* To implement your own non relational abstract domain,
 * first give the type of its elements, *)
type t =
  | Top
  | Bottom
  | Const of int

(* a printing function (useful for debuging), *)
let fprint ff = function
  | Top -> Format.fprintf ff "⊤"
  | Bottom -> Format.fprintf ff "⊥"
  | Const n -> Format.fprintf ff "%d" n
;;

(* the order of the lattice. *)
let order x y =
  match x, y with
  | _, Top -> true
  | Bottom, _ -> true
  | Const x, Const y -> x = y
  | _, _ -> false
;;

(* and infimums of the lattice. *)
let top = Top
let bottom = Bottom

(* All the functions below are safe overapproximations.
 * You can keep them as this in a first implementation,
 * then refine them only when you need it to improve
 * the precision of your analyses. *)

let join x y =
  match x, y with
  | Top, _ -> Top
  | _, Top -> Top
  | ens, Bottom -> ens
  | Bottom, ens -> ens
  | Const x, Const y ->
    if x = y then
      Const x
    else
      Top
;;

let meet x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Top, ens -> ens
  | ens, Top -> ens
  | Const x, Const y ->
    if x = y then
      Const x
    else
      Bottom
;;

let widening = join

(* Ok, maybe you'll need to implement this one if your lattice has infinite
  ascending chains and you want your analyses to terminate. *)

let sem_itv n1 n2 =
  if n1 > n2 then
    Bottom
  else if n1 = n2 then
    Const n1
  else
    Top
;;

let sem_plus x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Top, _ -> Top
  | _, Top -> Top
  | Const x, Const y -> Const (x + y)
;;

let sem_minus x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Top, _ -> Top
  | _, Top -> Top
  | Const x, Const y -> Const (x - y)
;;

let sem_times x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Const 0, _ -> Const 0
  | _, Const 0 -> Const 0
  | Top, _ -> Top
  | _, Top -> Top
  | Const x, Const y -> Const (x * y)
;;

(* si division par 0, on fait bottom *)
let sem_div x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | _, Const 0 -> Bottom
  | Top, _ -> Top
  | _, Top -> Top
  | Const x, Const y -> Const (x / y)
;;

let sem_guard = function
  | t -> t
;;

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y
