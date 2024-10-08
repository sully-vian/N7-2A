(****** Algorithmes combinatoires et listes ********)


(*** Code binaires de Gray ***)

(* Fonction qui génère un code de Gray
 * Paramètre n : (int) la taille du code
 * Résultat : (int list list) le code sous forme de int list list
 *)


let rec gray_code n =
    if (n = 0) then
        [[]]
    else
        let l' = gray_code (n-1) in
        let l0 = List.map (fun l -> 0::l) l' in
        let l1 = List.map (fun l -> 1::l) l' in
        l0 @ (List.rev l1)

(* TESTS *)
let%test _ = gray_code 0 = [[]]
let%test _ = gray_code 1 = [[0]; [1]]
let%test _ = gray_code 2=  [[0; 0]; [0; 1]; [1; 1]; [1; 0]]
let%test _ = gray_code 3 = [[0; 0; 0]; [0; 0; 1]; [0; 1; 1]; [0; 1; 0]; [1; 1; 0]; [1; 1; 1]; [1; 0; 1];
 [1; 0; 0]]
 let%test _ = gray_code 4 = [[0; 0; 0; 0]; [0; 0; 0; 1]; [0; 0; 1; 1]; [0; 0; 1; 0]; [0; 1; 1; 0];
  [0; 1; 1; 1]; [0; 1; 0; 1]; [0; 1; 0; 0]; [1; 1; 0; 0]; [1; 1; 0; 1];
  [1; 1; 1; 1]; [1; 1; 1; 0]; [1; 0; 1; 0]; [1; 0; 1; 1]; [1; 0; 0; 1];
  [1; 0; 0; 0]]


(*** Combinaisons d'une liste ***)

(* Fonction qui renvoie la liste de toutes les combinaisons possibles de k
éléments dans l
 * Paramètre k : (int) le nombre d'élémnts à prendre dans l
 * Paramètre l : ('a list) la liste dont on veut k éléments
 * Résultats : ('a list list) la liste de toutes les combinaisons possibles de k
 * Pré : |l| >= k >= 0
 * Post : - L'ordre initial des éléments est gardé dans chacune des combinaisons
 *        - l' = combinaisons k l =>|l| = n! / ((n-k)! k!)
 *)
let rec combinaisons k l =
    match k,l with
    | 0,_ -> [[]]
    | _,[] -> []
    | _,h::t ->
        let l1 = List.map (fun l' -> h::l') (combinaisons (k-1) t) in
        let l2 = combinaisons k t in
        l1@l2

(* TESTS *)
let%test _ = combinaisons 3 [1;2;3;4] = [[1;2;3]; [1;2;4]; [1;3;4]; [2;3;4]]
let%test _ = combinaisons 1 ['a';'b';'c'] = [['a'];['b'];['c']]
let%test _ = combinaisons 3 [1;2;3] = [[1;2;3]]
let%test _ = combinaisons 0 [true;false;true;false;false] = [[]]
let%test _ = combinaisons 12 [] = []


(*** Permutations d'une liste ***)

(* Fonction prend en paramètre un élément e et une liste l et qui insére e à toutes les possitions possibles dans l
 * Pamaètre e : ('a) l'élément à insérer
 * Paramètre l : ('a list) la liste initiale dans laquelle insérer e
 * Résultat : la liste des listes avec toutes les insertions possible de e dans l
* Post : soit l' = insertions e l,
 *        => (|l'| = |l|+1) /\ (e' appartient à l' => |e'| = |l|+1)
 *)

let rec insertion e l =
    match l with
    | [] -> [[e]]
    | h::t -> let insert_t = insertion e t in
    (e::l)::(List.map (fun l' -> h::l') insert_t)

(* TESTS *)
let%test _ = insertion 0 [1;2] = [[0;1;2];[1;0;2];[1;2;0]]
let%test _ = insertion 0 [] = [[0]]
let%test _ = insertion 3 [1;2] = [[3;1;2];[1;3;2];[1;2;3]]
let%test _ = insertion 3 [] = [[3]]
let%test _ = insertion 5 [12;54;0;3;78] =
[[5; 12; 54; 0; 3; 78]; [12; 5; 54; 0; 3; 78]; [12; 54; 5; 0; 3; 78];
 [12; 54; 0; 5; 3; 78]; [12; 54; 0; 3; 5; 78]; [12; 54; 0; 3; 78; 5]]
 let%test _ = insertion 'x' ['a';'b';'c']=
 [['x'; 'a'; 'b'; 'c']; ['a'; 'x'; 'b'; 'c']; ['a'; 'b'; 'x'; 'c'];
  ['a'; 'b'; 'c'; 'x']]

(* Fonction qui renvoie la liste des permutations d'une liste
 * Paramètre l : ('a list) une liste
 * Résultat : ('a list list) la liste des permutatiions de l (toutes différentes si les élements de l sont différents deux à deux
 *)

let rec permutations l =
    match l with
    | [] -> [[]]
    | h::t -> List.flatten (List.map (insertion h) (permutations t))

(* TESTS *)
let l1 = permutations [1;2;3]
let%test _ = List.length l1 = 6
let%test _ = List.mem [1; 2; 3] l1
let%test _ = List.mem [2; 1; 3] l1
let%test _ = List.mem [2; 3; 1] l1
let%test _ = List.mem [1; 3; 2] l1
let%test _ = List.mem [3; 1; 2] l1
let%test _ = List.mem [3; 2; 1] l1
let%test _ = permutations [] =[[]]
let l2 = permutations ['a';'b']
let%test _ = List.length l2 = 2
let%test _ = List.mem ['a';'b'] l2
let%test _ = List.mem ['b';'a'] l2

(*** Partition d'un entier ***)

(* partitions: int -> int list
 * Fonction qui calcule toutes les partitions possibles d'un entier n
 * Paramètre n : un entier dont on veut calculer les partitions
 * Préconditions : n >0
 * Retour : les partitions de n
*)

let partitions n =
    let rec aux t n =
    if (t > n) then
        []
    else if (t = n) then
        [[n]]
    else
        let lt = List.map (fun l' -> t::l') (aux t (n-t)) in
        let l = aux (t+1) n in
        lt@l
    in aux 1 n

(* TEST *)
let%test _ = partitions 1 = [[1]]
let%test _ = partitions 2 = [[1;1];[2]]
let%test _ = partitions 3 = [[1; 1; 1]; [1; 2]; [3]]
let%test _ = partitions 4 = [[1; 1; 1; 1]; [1; 1; 2]; [1; 3]; [2; 2]; [4]]
