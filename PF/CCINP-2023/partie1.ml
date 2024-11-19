let longueur l =
  let rec aux acc = function
    | [] -> acc
    | _ :: t -> aux (1 + acc) t
  in
  aux 0 l
;;

let rec insertion l a =
  match l with
  | [] -> [ a ]
  | h :: t -> if h < a then h :: insertion t a else a :: l
;;

let rec tri_insertion = function
  | [] -> []
  | h :: t -> insertion (tri_insertion t) h
;;

let rec selection_n l n =
  match l with
  | [] -> failwith "liste trop courte !"
  | h :: t -> if n = 0 then h else selection_n t (n - 1)
;;

let rec paquets_de_cinq = function
  | h1 :: h2 :: h3 :: h4 :: h5 :: t -> [ h1; h2; h3; h4; h5 ] :: paquets_de_cinq t
  | l -> [ l ]
;;

let medians l =
  List.map (fun l' -> selection_n l' (longueur l' / 2)) (List.map tri_insertion l)
;;

let partage p l =
  let rec aux l' l1 l2 n1 n2 =
    match l' with
    | [] -> l1, l2, n1, n2
    | h :: t ->
      if h <= p then aux t (h :: l1) l2 (n1 + 1) n2 else aux t l1 (h :: l2) n1 (n2 + 2)
  in
  aux l [] [] 0 0
;;
