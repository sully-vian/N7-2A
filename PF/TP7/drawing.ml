open Flux
open Simulation1

(* Module de représentation graphique d'une balle en 2D         *)
(* la simulation s'obtient en appliquant draw à un flux d'états *)
module Drawing (F : Frame) = struct
  let draw : etat flux -> unit =
    fun r ->
    let ref_r = ref r in
    let ref_handler_alrm = ref Sys.(Signal_handle (fun _ -> ())) in
    let ref_handler_int = ref Sys.(Signal_handle (fun _ -> ())) in
    let handler_alrm _ =
      match Flux.uncons !ref_r with
      | None ->
        Sys.(set_signal sigalrm !ref_handler_alrm);
        Sys.(set_signal sigint !ref_handler_int)
      | Some (((x, y), (_, _)), r') ->
        (*Format.printf "r=(%f, %f); dr = (%f, %f)@." x y dx dy;*)
        Graphics.clear_graph ();
        Graphics.draw_circle (int_of_float x) (int_of_float y) 5;
        Graphics.synchronize ();
        (*ignore (read_line ());*)
        ref_r := r'
    in
    let handler_int _ = ref_r := Flux.vide in
    let inf_x, sup_x = F.box_x in
    let inf_y, sup_y = F.box_y in
    let size_x = int_of_float (sup_x -. inf_x) in
    let size_y = int_of_float (sup_y -. inf_y) in
    Graphics.open_graph (Format.sprintf " %dx%d" size_x size_y);
    Graphics.auto_synchronize false;
    Sys.(ref_handler_alrm := signal sigalrm (Signal_handle handler_alrm));
    Sys.(ref_handler_int := signal sigint (Signal_handle handler_int));
    (* ignore return to fix type *)
    ignore Unix.(setitimer ITIMER_REAL { it_interval = F.dt; it_value = F.dt })
  ;;
end
