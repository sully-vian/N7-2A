module GreenThreads = struct
  (* à compléter/modifier *)
  type res =
    | Done
    | Yield of (unit -> res)
    | Fork of ((unit -> unit) * (unit -> res))

  let prompt0 = Delimcc.new_prompt ()

  let scheduler : (unit -> unit) -> unit =
   fun prog_init ->
    let rec loop : (unit -> res) Queue.t -> unit =
     fun queue ->
      if Queue.is_empty queue
      then ()
      else (
        match Delimcc.push_prompt prompt0 (Queue.pop queue) with
        | Done -> loop queue
        | Yield proc ->
          Queue.push proc queue;
          loop queue
        | Fork (new_prog, kproc) ->
          let new_proc () = Fork (new_prog, fun () -> Done) in
          Queue.push new_proc queue;
          Queue.push kproc queue;
          loop queue)
    in
    let queue = Queue.create () in
    (* Transformer le programme init en processus *)
    let proc_init () = Fork (prog_init, fun () -> Done) in
    Queue.push proc_init queue;
    loop queue
 ;;

  (* rend la main au scheduler qui doit le rempiler *)
  let yield : unit -> unit = fun () -> Delimcc.shift prompt0 (fun k -> Yield k)

  (* rend la main pr démarrer l'exec de p *)
  let fork : (unit -> unit) -> unit =
   fun proc -> Delimcc.shift prompt0 (fun k -> Fork (proc, k))
 ;;

  (* termine l'exec du proc, le scheduler ne doit pas rempiler *)
  let exit : unit -> unit = fun () -> Delimcc.shift prompt0 (fun _ -> Done)
end

module type Channel = sig
  val create : unit -> ('a -> unit) * (unit -> 'a)
end

module GTChannel : Channel = struct
  (* à compléter/modifier *)
  let create () = assert false
end

(* affiche tous les nombres premiers de 2 à 1000 *)
let sieve () =
  let rec filter reader =
    GreenThreads.(
      let v0 = reader () in
      if v0 = -1 then exit () else Format.printf "%d@." v0;
      yield ();
      let writer', reader' = GTChannel.create () in
      fork (fun () -> filter reader');
      while true do
        let v = reader () in
        yield ();
        if v mod v0 <> 0 then writer' v;
        if v = -1 then exit ()
      done)
  in
  let main () =
    GreenThreads.(
      let writer, reader = GTChannel.create () in
      fork (fun () -> filter reader);
      for i = 2 to 1000 do
        writer i;
        yield ()
      done;
      writer (-1);
      exit ())
  in
  GreenThreads.scheduler main
;;
