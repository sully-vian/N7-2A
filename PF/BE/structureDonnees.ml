(* Pour les tests *)
(* [eq_perm l l'] retourne true ssi [l] et [l']
   sont égales à à permutation près (pour (=)).
   [l'] ne doit pas contenir de doublon. *)
let eq_perm l l' =
  List.length l = List.length l' && List.for_all (fun x -> List.mem x l) l'

module type StructureDonnees = sig
  (* Type permettant de stocker le dictionnaire *)
  type dico

  (* Dictionnaire vide *)
  val empty : dico

  (* Ajoute un mot et son encodage au dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* deuxième paramètre : le mot *)
  (* troisième paramètre : le dictionnaire *)
  val ajouter : int list -> string -> dico -> dico

  (* Cherche tous les mots associés à un encodage dans un dictionnaire *)
  (* premier parametre : l'encodage du mot *)
  (* second paramètre : le dictionnaire *)
  val chercher : int list -> dico -> string list

  (* Calcule le nombre maximum de mots ayant le même encodage dans un
     dictionnaire *)
  (* paramètre : le dictionnaire *)
  val max_mots_code_identique : dico -> int

  (* Liste tous les mots d'un dictionnaire dont un prefixe de l'encodage est donné en paramètre *)
  (* premier paramètre : le prefixe de l'encodage *)
  (* second paramètre : le dictionnaire *)
  val prefixe : int list -> dico -> string list
end

module ListAssoc :
  StructureDonnees with type dico = (int list * string list) list = struct
  type dico = (int list * string list) list

  let empty = []

  let rec ajouter encodage mot dict =
    match dict with
    | [] -> [ (encodage, [ mot ]) ]
    | (code, mots) :: reste_dict ->
        if code = encodage then (code, mot :: mots) :: reste_dict
        else (code, mots) :: ajouter encodage mot reste_dict

  let chercher encodage dict =
    match List.assoc_opt encodage dict with None -> [] | Some x -> x

  let rec max_mots_code_identique dict =
    match dict with
    | [] -> 0
    | (_, mots) :: reste_dict ->
        max (List.length mots) (max_mots_code_identique reste_dict)

  (* Vérifie si pref est un préfixe de l *)
  let rec est_prefixe pref l =
    match (pref, l) with
    | [], _ -> true
    | _, [] -> false
    | h1 :: t1, h2 :: t2 -> h1 = h2 && est_prefixe t1 t2

  let rec prefixe pref dict =
    match dict with
    | [] -> []
    | (code, mots) :: reste_dict ->
        let prefixe_reste = prefixe pref reste_dict in
        if est_prefixe pref code then mots @ prefixe_reste else prefixe_reste

  let%test _ = est_prefixe [] []
  let%test _ = est_prefixe [] [ 1; 2; 3 ]
  let%test _ = est_prefixe [ 1 ] [ 1; 2; 3 ]
  let%test _ = est_prefixe [ 1; 2 ] [ 1; 2 ]
  let%test _ = est_prefixe [ 1; 2 ] [ 1; 2; 3 ]
  let%test _ = not (est_prefixe [ 1; 2; 3 ] [ 1; 2 ])
  let%test _ = eq_perm (ajouter [ 2; 2 ] "aa" empty) [ ([ 2; 2 ], [ "aa" ]) ]

  let%test _ =
    eq_perm
      (ajouter [ 2; 2 ] "bb" [ ([ 2; 2 ], [ "aa" ]) ])
      [ ([ 2; 2 ], [ "bb"; "aa" ]) ]

  let%test _ =
    eq_perm
      (ajouter [ 6; 2; 2; 6; 5 ] "ocaml" [ ([ 2; 2 ], [ "aa" ]) ])
      [ ([ 2; 2 ], [ "aa" ]); ([ 6; 2; 2; 6; 5 ], [ "ocaml" ]) ]

  let%test _ =
    eq_perm
      (chercher [ 2; 2 ]
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bb"; "aa"; "cc" ]

  let%test _ =
    eq_perm
      (chercher [ 3; 3 ]
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      []

  let%test _ =
    eq_perm
      (chercher [ 2; 7; 3; 3 ]
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bref" ]

  let%test _ =
    eq_perm
      (chercher [ 2; 6; 6 ]
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bon" ]

  let%test _ = eq_perm (chercher [ 2; 6; 6 ] []) []

  let%test _ =
    max_mots_code_identique
      [
        ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
        ([ 2; 7; 3; 3 ], [ "bref" ]);
        ([ 2; 6; 6 ], [ "bon" ]);
      ]
    = 3

  let%test _ =
    max_mots_code_identique
      [
        ([ 2; 7; 3; 3 ], [ "bref" ]);
        ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
        ([ 2; 6; 6 ], [ "bon" ]);
      ]
    = 3

  let%test _ = max_mots_code_identique [] = 0

  let%test _ =
    max_mots_code_identique
      [
        ([ 2; 7; 3; 3 ], [ "bref" ]);
        ([ 2; 2 ], [ "bb" ]);
        ([ 2; 6; 6 ], [ "bon" ]);
      ]
    = 1

  let%test _ =
    eq_perm
      (prefixe []
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bb"; "aa"; "cc"; "bref"; "bon" ]

  let%test _ =
    eq_perm
      (prefixe []
         [
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bref"; "bb"; "aa"; "cc"; "bon" ]

  let%test _ = eq_perm (prefixe [] []) []

  let%test _ =
    eq_perm
      (prefixe []
         [
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 2 ], [ "bb" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bref"; "bb"; "bon" ]

  let%test _ =
    eq_perm
      (prefixe [ 2 ]
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bb"; "aa"; "cc"; "bref"; "bon" ]

  let%test _ =
    eq_perm
      (prefixe [ 2; 2 ]
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bb"; "aa"; "cc" ]

  let%test _ =
    eq_perm
      (prefixe [ 2; 2 ]
         [
           ([ 2; 2 ], [ "bb"; "aa"; "cc" ]);
           ([ 2; 7; 3; 3 ], [ "bref" ]);
           ([ 2; 2; 2 ], [ "bac"; "bab" ]);
           ([ 2; 6; 6 ], [ "bon" ]);
         ])
      [ "bb"; "aa"; "cc"; "bac"; "bab" ]
end

(* On définit le type hors du module pour l'aliaser *)
type type_dico = Noeud of (string list * (int * type_dico) list)

module Arbre : StructureDonnees with type dico = type_dico = struct
  type dico = type_dico

  let empty = Noeud ([], [])

  (* FIXME: manque la reconstruction, besoin d'une autre fonction que List.assoc pour replacer la branche au bon endroit *)
  let rec ajouter code mot (Noeud (mots, branches)) =
    match code with
    | [] -> Noeud (mot :: mots, branches)
    | code_h :: code_t -> (
        (*récupérer la bonne branche, sinon, la créer*)
        match List.assoc_opt code_h branches with
        | Some dict -> ajouter code_t mot dict
        | None -> Noeud ([], [ (code_h, ajouter code_t mot empty) ]))

  let rec chercher code (Noeud (mots, branches)) =
    match code with
    | [] -> mots
    | code_h :: code_t -> (
        match List.assoc_opt code_h branches with
        | Some dict -> chercher code_t dict
        | None -> [])

  let rec max_mots_code_identique (Noeud (mots, branches)) =
    let liste_max =
      List.map (fun (_, dict) -> max_mots_code_identique dict) branches
    in
    List.fold_right max (List.length mots :: liste_max) 0

  (* Renvoie la liste des mots contenus dans le dictionnaire *)
  let rec contenu (Noeud (mots, branches)) =
    let mots_branches = List.map (fun (_, dict) -> contenu dict) branches in
    List.flatten (mots :: mots_branches)

  let rec prefixe pref (Noeud (mots, branches)) =
    match pref with
    | [] -> contenu (Noeud (mots, branches))
    | pref_h :: pref_t -> (
        match List.assoc_opt pref_h branches with
        | Some branche -> prefixe pref_t branche
        | None -> [])

  (* TESTS - ATTENTION les tests peuvent échouer car l'ordre des branches n'est pas fixé *)

  let a1 =
    Noeud
      ( [],
        [
          ( 2,
            Noeud
              ( [],
                [
                  ( 6,
                    Noeud
                      ( [],
                        [
                          ( 6,
                            Noeud
                              ( [],
                                [
                                  ( 5,
                                    Noeud
                                      ( [],
                                        [
                                          ( 6,
                                            Noeud
                                              ( [],
                                                [
                                                  ( 8,
                                                    Noeud
                                                      ( [],
                                                        [
                                                          ( 7,
                                                            Noeud
                                                              ([ "bonjour" ], [])
                                                          );
                                                        ] ) );
                                                ] ) );
                                        ] ) );
                                ] ) );
                        ] ) );
                ] ) );
        ] )

  let%test _ = a1 = ajouter [ 2; 6; 6; 5; 6; 8; 7 ] "bonjour" empty

  let a2 =
    Noeud
      ( [],
        [
          ( 6,
            Noeud
              ( [],
                [
                  ( 2,
                    Noeud
                      ( [],
                        [
                          ( 2,
                            Noeud
                              ( [],
                                [
                                  ( 6,
                                    Noeud ([], [ (5, Noeud ([ "ocaml" ], [])) ])
                                  );
                                ] ) );
                        ] ) );
                ] ) );
        ] )

  let%test _ = a2 = ajouter [ 6; 2; 2; 6; 5 ] "ocaml" empty

  let a3 =
    Noeud
      ( [],
        [
          (2, Noeud ([ "a" ], []));
          ( 6,
            Noeud
              ( [],
                [
                  ( 2,
                    Noeud
                      ( [],
                        [
                          ( 2,
                            Noeud
                              ( [],
                                [
                                  ( 6,
                                    Noeud ([], [ (5, Noeud ([ "ocaml" ], [])) ])
                                  );
                                ] ) );
                        ] ) );
                ] ) );
        ] )

  let%test _ = a3 = ajouter [ 2 ] "a" a2
  let a4 = Noeud ([], [ (2, Noeud ([], [ (8, Noeud ([ "au" ], [])) ])) ])
  let%test _ = a4 = ajouter [ 2; 8 ] "au" empty

  let a5 =
    Noeud
      ( [],
        [
          ( 2,
            Noeud ([], [ (6, Noeud ([ "an" ], [])); (8, Noeud ([ "au" ], [])) ])
          );
        ] )

  let%test _ = a5 = ajouter [ 2; 6 ] "an" a4

  let a6 =
    Noeud
      ( [],
        [
          ( 2,
            Noeud
              ( [],
                [
                  (6, Noeud ([ "an" ], [ (3, Noeud ([ "ane" ], [])) ]));
                  (8, Noeud ([ "au" ], []));
                ] ) );
        ] )

  let%test _ = a6 = ajouter [ 2; 6; 3 ] "ane" a5

  let a7 =
    Noeud
      ( [],
        [
          ( 2,
            Noeud
              ( [],
                [
                  (6, Noeud ([ "an" ], [ (3, Noeud ([ "ame"; "ane" ], [])) ]));
                  (8, Noeud ([ "au" ], []));
                ] ) );
        ] )

  let%test _ = a7 = ajouter [ 2; 6; 3 ] "ame" a6

  let a8 =
    Noeud
      ( [],
        [
          ( 2,
            Noeud
              ( [],
                [
                  ( 6,
                    Noeud
                      ([ "an" ], [ (3, Noeud ([ "bof"; "ame"; "ane" ], [])) ])
                  );
                  (8, Noeud ([ "au" ], []));
                ] ) );
        ] )

  let%test _ = a8 = ajouter [ 2; 6; 3 ] "bof" a7

  let a9_1 =
    Noeud
      ( [],
        [
          ( 2,
            Noeud
              ( [],
                [
                  ( 6,
                    Noeud
                      ([ "an" ], [ (3, Noeud ([ "bof"; "ame"; "ane" ], [])) ])
                  );
                  (8, Noeud ([ "bu"; "au" ], []));
                ] ) );
        ] )

  let a9_2 =
    Noeud
      ( [],
        [
          ( 2,
            Noeud
              ( [],
                [
                  (8, Noeud ([ "bu"; "au" ], []));
                  ( 6,
                    Noeud
                      ([ "an" ], [ (3, Noeud ([ "bof"; "ame"; "ane" ], [])) ])
                  );
                ] ) );
        ] )

  let%test _ =
    a9_1 = ajouter [ 2; 8 ] "bu" a8 || a9_2 = ajouter [ 2; 8 ] "bu" a8

  let%test _ = eq_perm (chercher [ 2; 8 ] a9_1) [ "bu"; "au" ]
  let%test _ = eq_perm (chercher [ 2; 6 ] a9_1) [ "an" ]
  let%test _ = eq_perm (chercher [ 2; 6; 3 ] a9_1) [ "bof"; "ame"; "ane" ]
  let%test _ = eq_perm (chercher [ 1; 4; 5 ] a9_1) []
  let%test _ = eq_perm (chercher [ 2; 8 ] a9_2) [ "bu"; "au" ]
  let%test _ = eq_perm (chercher [ 2; 6 ] a9_2) [ "an" ]
  let%test _ = eq_perm (chercher [ 2; 6; 3 ] a9_2) [ "bof"; "ame"; "ane" ]
  let%test _ = eq_perm (chercher [ 1; 4; 5 ] a9_2) []
  let%test _ = max_mots_code_identique a9_1 = 3
  let%test _ = max_mots_code_identique a9_2 = 3
  let%test _ = max_mots_code_identique a8 = 3
  let%test _ = max_mots_code_identique a7 = 2
  let%test _ = max_mots_code_identique a6 = 1
  let%test _ = max_mots_code_identique a5 = 1
  let%test _ = max_mots_code_identique a4 = 1
  let%test _ = max_mots_code_identique a3 = 1
  let%test _ = max_mots_code_identique a2 = 1
  let%test _ = max_mots_code_identique a1 = 1

  let%test _ =
    eq_perm (prefixe [ 2 ] a9_1) [ "ame"; "an"; "ane"; "au"; "bof"; "bu" ]

  let%test _ = eq_perm (prefixe [ 2; 6 ] a9_1) [ "ame"; "an"; "ane"; "bof" ]
  let%test _ = eq_perm (prefixe [ 2; 8 ] a9_1) [ "au"; "bu" ]
  let%test _ = eq_perm (prefixe [ 3; 8 ] a9_1) []

  let%test _ =
    eq_perm (prefixe [] a9_1) [ "ame"; "an"; "ane"; "au"; "bof"; "bu" ]

  let%test _ =
    eq_perm (prefixe [] a9_2) [ "ame"; "an"; "ane"; "au"; "bof"; "bu" ]

  let%test _ = eq_perm (prefixe [] a6) [ "an"; "ane"; "au" ]
end
