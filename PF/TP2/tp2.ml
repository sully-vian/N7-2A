(******* TRIS ******)

(*  Tri par insertion **)

(* Fonction qui ajoute un élément dans une liste triée, selon un ordre donné
 * Type : ('a->'a->bool)->'a->'a list -> 'a list
 * Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : elt, l'élement à ajouter
 * Paramètre : l, la liste triée dans laquelle ajouter elt
 * Résultat : une liste triée avec les éléments de l, plus elt
 *)

let rec insert ordre elt l =
    match l with
    | [] -> [elt]
    | h::t ->
        if (ordre elt h) then
            elt::l
        else
            h::(insert ordre elt t)

(* TESTS *)
let%test _ = insert (<) 3 []=[3]
let%test _ = insert (<) 3 [2;4;5]=[2;3;4;5]
let%test _ = insert (>) 6 [3;2;1]=[6;3;2;1]

(* Fonction qui trie une liste, selon un ordre donné
 * Type : ('a->'a->bool)->'a list -> 'a list
 * Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : l, la liste à trier
 * Résultat : une liste triée avec les éléments de l
 *)

let rec tri_insertion ordre l =
    match l with
    | [] -> []
    | h::t -> insert ordre h (tri_insertion ordre t)

(* TESTS *)
let%test _ = tri_insertion (<) [] =[]
let%test _ = tri_insertion (<) [4;2;4;3;1] =[1;2;3;4;4]
let%test _ = tri_insertion (>) [4;7;2;4;1;2;2;7]=[7;7;4;4;2;2;2;1]

(* Fonction qui trie une liste, selon un ordre donné en usant de List.fold_right
 * Type : ('a->'a->bool)->'a list -> 'a list
 * Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : l, la liste à trier
 * Résultat : une liste triée avec les éléments de l
 *)

let tri_insertion_fold ordre l = List.fold_right (insert ordre) l []

(* TESTS *)
let%test _ = tri_insertion_fold (<) [] = []
let%test _ = tri_insertion_fold (<) [4;2;4;3;1] =[1;2;3;4;4]
let%test _ = tri_insertion_fold (>) [4;7;2;4;1;2;2;7]=[7;7;4;4;2;2;2;1]

(*  Tri fusion **)

(* Fonction qui décompose une liste en deux listes de tailles égales à plus ou moins un élément
 * Paramètre : l, la liste à couper en deux
 * Retour : deux listes
 *)

let rec scinde l =
    match l with
    | [] -> [],[]
    | [x] -> [x], []
    | h1::h2::t ->
        let t1,t2 = scinde t in
        (h1::t1), (h2::t2)

(* TESTS *)
(* Peuvent être modifiés selon l'algorithme choisi *)
let%test _ = scinde [1;2;3;4] = ([1;3],[2;4])
let%test _ = scinde [1;2;3] = ([1;3],[2])
let%test _ = scinde [1] = ([1],[])
let%test _ = scinde [] = ([],[])

(* Fusionne deux listes triées pour en faire une seule triée
 * Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : l1 et l2, les deux listes triées
 * Résultat : une liste triée avec les éléments de l1 et l2
 *)

let rec fusionne ordre l1 l2 =
    match l1, l2 with
    | [],_ -> l2
    | _,[] -> l1
    | (h1::t1), (h2::t2) ->
        if (ordre h1 h2) then
            h1::(fusionne ordre t1 l2)
        else
            h2::(fusionne ordre l1 t2)

(* TESTS *)
let%test _ = fusionne (<) [1;2;4;5;6] [3;4] = [1;2;3;4;4;5;6]
let%test _ = fusionne (<) [1;2;4] [3;4] = [1;2;3;4;4]
let%test _ = fusionne (<) [1;2;4] [3;4;8;9;10] = [1;2;3;4;4;8;9;10]
let%test _ = fusionne (<) [] [] = []
let%test _ = fusionne (<) [1] [] = [1]
let%test _ = fusionne (<) [] [1] = [1]
let%test _ = fusionne (<) [1] [2] = [1;2]
let%test _ = fusionne (>) [1] [2] = [2;1]


(* Fonction qui trie une liste, selon un ordre donné
 * Type : ('a->'a->bool)->'a list -> 'a list
 * Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : l, la liste à trier
 * Résultat : une liste triée avec les éléments de l
 *)

let rec tri_fusion ordre l =
    match l with
    | [] | [_] -> l
    | _ ->
        let l1,l2 = scinde l in
        fusionne ordre (tri_fusion ordre l1) (tri_fusion ordre l2)

(* TESTS *)
let%test _ = tri_fusion (<) [] = []
let%test _ = tri_fusion (<) [4;2;4;3;1] = [1;2;3;4;4]
let%test _ = tri_fusion (>) [4;7;2;4;1;2;2;7] = [7;7;4;4;2;2;2;1]


(*  Parsing du fichier *)
open Lexing

(* Affiche un quadruplet composé
- du sexe des personnes ayant reçu ce prénom : 1 pour les hommes, 2 pour les femmes
- du prénom
- de l'année
- du nombre de fois où ce prénom a été donné cette année là
*)
let print_stat (sexe,nom,annee,nb) =
  Printf.eprintf "%s,%s,%d,%d%!\n" (if (sexe=1) then "M" else "F") nom annee nb

(* Affiche une liste de quadruplets tels que définis ci-dessus
 *)
let rec print_stat_list l =
    match l with
    | [] -> ()
    | h::t -> print_stat h; print_stat_list t

(* Analyse le fichier nat2016.txt (stratistique des prénoms entre 1900 et 2016)
 et construit une liste de quadruplet (sexe,prénom,année,nombre d'affectation)
*)
let listStat =
  let input = open_in "/home/sully_vian/Downloads/nat2016.txt" in
  let filebuf = Lexing.from_channel input in
  Parser.main Lexer.token filebuf


(* Analyse le fichier nathomme2016.txt (stratistique des prénoms d'homme commençant par un A ou un B entre 1900 et 2016)
 et construit une liste de quadruplets (sexe,prénom,année,nombre d'affectations)
*)
let listStatHomme =
  let input = open_in "/home/sully_vian/Downloads/nathomme2016.txt" in
  let filebuf = Lexing.from_channel input in
  Parser.main Lexer.token filebuf

(* Fonction qui renvoie le dernier élément d'un quadruplet
 * Type : 'a * 'b * 'c * 'd -> 'd
 * Paramètre : un quadruplet
 * Résultat : le dernier élément du quadruplet
 *)
let no4 (_,_,_,n) = n

(* TESTS *)
let%test _ = no4 (1,"toto",2016,5) = 5
let%test _ = no4 (2,"tata",2016,3) = 3
let%test _ = no4 (1,"titi",2016,1) = 1

(* Fonction qui renvoie un ordre sur les quadruplets selon le dernier élément
 * Paramètre : ordre ('a->'a->bool), un ordre sur les éléments de la liste
 * Résultat : la composée de l'ordre et de la fonction no4
 *)
let ordre_no4 ordre = fun x y -> ordre (no4 x) (no4 y)

(* TESTS *)
let%test _ = ordre_no4 (<) (1,"toto",2016,3) (2,"tata",2016,5) = true
let%test _ = ordre_no4 (<) (2,"tata",2016,-1) (1,"toto",2016,5) = true
let%test _ = ordre_no4 (>) (1,"toto",2016,2) (2,"tata",2016,3) = false

(* Fonction qui décompose une liste en deux listes de tailles égales à plus ou moins un élément (version récursive terminale)
 * Paramètre : l, la liste à couper en deux
 * Retour : deux listes
 *)
 let scinde2 l =
    let rec aux l (acc1,acc2) =
        match l with
        | [] -> (acc1,acc2)
        | [x] -> (x::acc1, acc2)
        | h1::h2::t -> aux t (h1::acc1, h2::acc2)
    in aux l ([],[])

(* TESTS *)
(* Peuvent être modifiés selon l'algorithme choisi *)
let%test _ = scinde2 [1;2;3;4] = ([3;1],[4;2])
let%test _ = scinde2 [1;2;3] = ([3;1],[2])
let%test _ = scinde2 [1] = ([1],[])
let%test _ = scinde2 [] = ([],[])


(* Fusionne deux listes triées selon un ordre pour en faire une seule triée selon la négation de cet ordre
 * Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : l1 et l2, les deux listes triées
 * Résultat : une liste triée avec les éléments de l1 et l2 selon la négation de l'ordre
 *)

let fusionne2 ordre l1 l2 =
    let rec aux l1 l2 acc =
        match l1,l2 with
        | [],_ -> (List.rev l2)@acc
        | _,[] -> (List.rev l1)@acc
        | (h1::t1), (h2::t2) ->
            if not (ordre h1 h2) then
                aux l1 t2 (h2::acc)
            else
                aux t1 l2 (h1::acc)
    in aux l1 l2 []

(* TESTS *)
let%test _ = fusionne2 (<) [1;2;4;5;6] [3;4] = List.rev [1;2;3;4;4;5;6]
let%test _ = fusionne2 (<) [1;2;4] [3;4] = List.rev [1;2;3;4;4]
let%test _ = fusionne2 (<) [1;2;4] [3;4;8;9;10] = List.rev [1;2;3;4;4;8;9;10]
let%test _ = fusionne2 (<) [] [] = List.rev []
let%test _ = fusionne2 (<) [1] [] = List.rev [1]
let%test _ = fusionne2 (<) [] [1] = List.rev [1]
let%test _ = fusionne2 (<) [1] [2] = List.rev [1;2]
let%test _ = fusionne2 (>) [1] [2] = List.rev [2;1]

(* Fonction qui renvoie la fonction opposée de l'ordre
 * Type : ('a->'a->bool)->'a->'a->bool
 * Paramètre : ordre ('a->'a->bool), un ordre sur les éléments de la liste
 * Résultat : l'ordre contraire
 *)
let neg_ordre ordre = fun x y -> not (ordre x y)

(* Fonction qui trie une liste, selon un ordre donné (version récursive terminale)
 * Type : ('a->'a->bool)->'a list -> 'a list
 * Paramètre : ordre  ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : l, la liste à trier
 * Résultat : une liste triée avec les éléments de l
 *)

let tri_fusion2 ordre l =
    let rec aux1 ordre l' =
        match l' with
        | [] | [_] -> l'
        | _ ->
            let l1,l2 = scinde2 l' in
            fusionne2 ordre (aux2 ordre l1) (aux2 ordre l2)

    and aux2 ordre l' =
        match l' with
        | [] | [_] -> l'
        | _ ->
            let l1,l2 = scinde2  l' in
            fusionne2 (neg_ordre ordre) (aux1 ordre l1) (aux1 ordre l2)
    in aux2 ordre l
let rec print_int_list l =
    match l with
    | [] -> ()
    | h::t -> (print_string (string_of_int h)); print_char ' '; print_int_list t

(* TESTS *)
let%test _ = tri_fusion2 (<) [] = []
let%test _ = tri_fusion2 (<) [4;2;4;3;1] = [1;2;3;4;4]
let%test _ = tri_fusion2 (<) [1;2;4;5;6] = [1;2;4;5;6]
let%test _ = tri_fusion2 (>) [4;7;2;4;1;2;2;7] = [7;7;4;4;2;2;2;1]
let%test _ = tri_fusion2 (<) [4;7;2;4;1;2;2;7] = [1;2;2;2;4;4;7;7]
let%test _ = tri_fusion2 (<) ['c';'a';'b';'d';'e'] = ['a';'b';'c';'d';'e']
let%test _ = tri_fusion2 (>) ['c';'a';'b'] = ['c';'b';'a']
let%test _ = tri_fusion2 (>) ['c';'a';'b'] = ['c';'b';'a']

(* let listStatTrieeNatif = List.sort (fun x y -> if (no4 x > no4 y) then 1 else -1) listStat
(* let listStatTriee = tri_fusion (fun x y -> (no4 x) > (no4 y)) listStat *)
let listStatTriee2 = tri_fusion2 (fun x y -> (no4 x) > (no4 y)) listStat *)

(* let%test _ = print_stat (List.hd listStatTrieeNatif) = ()
let%test _ = print_stat (List.hd (List.rev listStatTriee2)) = () *)
let rec n_firsts l n =
    match l with
    | [] -> []
    | h::t -> if n=0 then
        []
    else
        h::(n_firsts t (n-1))

let listStatSmall = n_firsts listStat 10
let listStatSmallTriee = tri_fusion (ordre_no4 (>)) listStatSmall
let listStatSmallTriee2 = tri_fusion2 (ordre_no4 (>)) listStatSmall
let listStatSmallTrieeNatif = List.sort (fun x y -> if (no4 x > no4 y) then 1 else -1) listStatSmall

(* Fonction qui teste si une liste est triée selon un ordre donné
 * Paramètre : ordre : ('a->'a->bool), un ordre sur les éléments de la liste
 * Paramètre : l : ('a list), la liste à tester
 *)
let rec est_triee ordre l =
    match l with
    | [] | [_] -> true
    | h1::h2::t -> (ordre h1 h2) && (est_triee ordre (h2::t))

(* TESTS *)
let%test _ =  est_triee (<) [1;2;3;4;5] = true
let%test _ =  est_triee (<) [1;2;3;4;5;3] = false
let%test _ =  est_triee (>) [5;4;3;2;1] = true

