open Nlist

let nlist1 = Cons (1, Cons (2, Cons (-2, Cons (7, Cons (0, Nil)))))
let nlist2 = Cons (3, Cons (4, Cons (-4, Cons (9, Cons (1, Nil)))))
let nlist3 = Cons (1, Cons (2, Cons (3, Cons (5, Cons (6, Nil)))))

(* map *)
let%test _ =
  map (fun n -> n - 1) nlist1 = Cons (0, Cons (1, Cons (-3, Cons (6, Cons (-1, Nil)))))
;;

let%test _ = map (fun n -> n) nlist2 = nlist2
let%test _ = map (fun n -> -n) Nil = Nil

(* snoc *)
let%test _ =
  snoc 1 nlist1 = Cons (1, Cons (2, Cons (-2, Cons (7, Cons (0, Cons (1, Nil))))))
;;

let%test _ =
  snoc 5 nlist2 = Cons (3, Cons (4, Cons (-4, Cons (9, Cons (1, Cons (5, Nil))))))
;;

let%test _ = snoc 0 Nil = Cons (0, Nil)

(* tail *)
let%test _ = tail nlist1 = Cons (2, Cons (-2, Cons (7, Cons (0, Nil))))
let%test _ = tail nlist2 = Cons (4, Cons (-4, Cons (9, Cons (1, Nil))))

(* rev *)
let%test _ = rev nlist1 = Cons (0, Cons (7, Cons (-2, Cons (2, Cons (1, Nil)))))
let%test _ = rev nlist2 = Cons (1, Cons (9, Cons (-4, Cons (4, Cons (3, Nil)))))
let%test _ = rev Nil = Nil
let%test _ = rev (Cons (1, Nil)) = Cons (1, Nil)

(* insert *)
let%test _ =
  insert 4 nlist3 = Cons (1, Cons (2, Cons (3, Cons (4, Cons (5, Cons (6, Nil))))))
;;

let%test _ =
  insert 0 nlist3 = Cons (0, Cons (1, Cons (2, Cons (3, Cons (5, Cons (6, Nil))))))
;;

let%test _ =
  insert 5 nlist3 = Cons (1, Cons (2, Cons (3, Cons (5, Cons (5, Cons (6, Nil))))))
;;

let%test _ = insert 0 Nil = Cons (0, Nil)

(* insertion_sort *)
let%test _ = insertion_sort nlist1 = Cons (-2, Cons (0, Cons (1, Cons (2, Cons (7, Nil)))))
let%test _ = insertion_sort nlist2 = Cons (-4, Cons (1, Cons (3, Cons (4, Cons (9, Nil)))))
