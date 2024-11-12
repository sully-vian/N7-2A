open Hlist

let hlist1 = Cons (1, Cons (true, Nil))
let hlist2 = Cons ('a', Cons (false, Cons (3, Nil)))

(* tail *)
let%test _ = tail hlist1 = Cons (true, Nil)
let%test _ = tail (Cons ('a', Nil)) = Nil
let%test _ = tail hlist2 = Cons (false, Cons (3, Nil))

(* add *)

let%test _ = add (Cons (1, Cons (2, Nil))) = Cons (3, Nil)
let%test _ = add (Cons (-1, Cons (7, Cons ("aaa", Nil)))) = Cons (6, Cons ("aaa", Nil))
