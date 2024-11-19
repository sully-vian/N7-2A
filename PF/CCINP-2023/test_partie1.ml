open Partie1

(* LONGUEUR *)
let%test _ = longueur [] = 0
let%test _ = longueur [ '0'; '1'; '2'; '3' ] = 4
let%test _ = longueur [ true; false; true; true; false ] = 5
let%test _ = longueur [ [ 0; 1; 2 ]; [ 1; 2; 3; 4; 4 ]; []; [ 3; 3; 22 ] ] = 4

(* INSERTION *)
let%test _ = insertion [] 2 = [ 2 ]
let%test _ = insertion [ 1; 2; 3; 4 ] 2 = [ 1; 2; 2; 3; 4 ]
let%test _ = insertion [ 1; 2; 3; 4 ] 0 = [ 0; 1; 2; 3; 4 ]
let%test _ = insertion [ 1; 2; 3; 4 ] 5 = [ 1; 2; 3; 4; 5 ]
let%test _ = insertion [ 1; 2; 3; 4 ] 3 = [ 1; 2; 3; 3; 4 ]

(* TRI_INSERTION *)
let%test _ = tri_insertion [] = []
let%test _ = tri_insertion [ 1; 2; 3; 4 ] = [ 1; 2; 3; 4 ]
let%test _ = tri_insertion [ 4; 3; 2; 1 ] = [ 1; 2; 3; 4 ]
let%test _ = tri_insertion [ 3; 4; 2; 1 ] = [ 1; 2; 3; 4 ]

(*  *)
