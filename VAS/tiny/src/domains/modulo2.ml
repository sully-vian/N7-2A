(* Template to write your own non relational abstract domain. *)

(* To implement your own non relational abstract domain,
 * first give the type of its elements, *)
type t =
  | Top
  | Bottom
  | Even
  | Odd

(* a printing function (useful for debuging), *)
let fprint ff = function
  | Top -> Format.fprintf ff "⊤"
  | Bottom -> Format.fprintf ff "⊥"
  | Even -> Format.fprintf ff "Even"
  | Odd -> Format.fprintf ff "Odd"
;;

(* the order of the lattice. *)
let order x y =
  match x, y with
  | _, Top -> true
  | Bottom, _ -> true
  | x, y -> x = y
;;

(* and infimums of the lattice. *)
let top = Top
let bottom = Bottom

let parity n =
  if n mod 2 = 0 then
    Even
  else
    Odd
;;

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
  | _, _ ->
    if x = y then
      x
    else
      Top
;;

(* intersection *)
let meet x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Top, ens -> ens
  | ens, Top -> ens
  | _, _ ->
    if x = y then
      x
    else
      Bottom
;;

let widening = join
(* Ok, maybe you'll need to implement this one if your
                      * lattice has infinite ascending chains and you want
                      * your analyses to terminate. *)

(* sémantique intervalle *)
let sem_itv n1 n2 =
  if parity n1 = parity n2 then
    parity n1
  else
    Top
;;

let sem_plus x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Top, _ -> Top
  | _, Top -> Top
  | _, _ ->
    if x = y then
      Even
    else
      Odd
;;

let sem_minus x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Top, _ -> Top
  | _, Top -> Top
  | _, _ ->
    if x = y then
      Even
    else
      Odd
;;

let sem_times x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | Top, _ -> Top
  | _, Top -> Top
  | Odd, Odd -> Odd
  | _, _ -> Even
;;

let sem_div x y =
  match x, y with
  | Bottom, _ -> Bottom
  | _, Bottom -> Bottom
  | _, _ -> Top
;;

let sem_guard = function
  | t -> t
;;

let backsem_plus x y r = x, y
let backsem_minus x y r = x, y
let backsem_times x y r = x, y
let backsem_div x y r = x, y
