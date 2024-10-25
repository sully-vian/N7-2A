type dico = Noeud of (string list * (int * dico) list)

let rec contenu (Noeud(mots, branches)) =
  let mots_branches = List.map (fun (touche, dict) -> contenu dict) branches in
  List.flatten (mots::mots_branches)