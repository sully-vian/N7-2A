open Drawing
open Simulation1
open Simulation2

module F : Frame = struct
  let dt = 0.01
  let box_x = 0., 500.
  let box_y = 0., 500.
end

module Draw = Drawing (F)
module NoBounce = FreeFall (F)
module Bounce = Bouncing (F)

let etat0 = (10., 90.), (1000., 0.)

let () =
  if Array.length Sys.argv <> 5
  then (
    Printf.eprintf "Usage:\n\t%sx0 <x0> <y0> <vx0> <vy0>\n\n" Sys.argv.(0);
    Printf.eprintf "Exemple:\n\t%s 100 450 300 0\n\n" Sys.argv.(0))
  else (
    let x0 = float_of_string Sys.argv.(1) in
    let y0 = float_of_string Sys.argv.(2) in
    let vx0 = float_of_string Sys.argv.(3) in
    let vy0 = float_of_string Sys.argv.(4) in
    let etat0 = (x0, y0), (vx0, vy0) in
    print_endline "simulating...";
    Draw.draw (Bounce.run etat0);
    try
      while true do
        Unix.sleep 1
      done
    with
    | _ -> Graphics.close_graph ())
;;
