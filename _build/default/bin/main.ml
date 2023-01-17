let () = print_endline "\n  Monitoring in progress... \n"

(* Define the states of the ASTD using a variant type *)
type state =
  | Nothing
  | Busy
  | Image_of_shadow_copies_deletion_attack
  | Possible_shadow_copies_deletion_attack

(* Define the events that can trigger transitions between states using another variant type *)
type event =
  | Start
  | Stop
  | Image_of_shadow_copies_deletion_attack
  | Possible_shadow_copies_deletion_attack

(* Define a function that represents the transitions between states.
   This function takes a current state and an event as input, and returns the next state. *)
let transition (current_state: state) (event: event) : state =
  match current_state, event with
  | Nothing, Start -> Busy
  | Busy, Stop -> Nothing
  | _, Image_of_shadow_copies_deletion_attack -> Image_of_shadow_copies_deletion_attack
  | Image_of_shadow_copies_deletion_attack, Stop -> Image_of_shadow_copies_deletion_attack
  | Image_of_shadow_copies_deletion_attack, Start -> Busy
  | Image_of_shadow_copies_deletion_attack, Possible_shadow_copies_deletion_attack -> Possible_shadow_copies_deletion_attack
  | Possible_shadow_copies_deletion_attack, Stop -> Nothing
  | _ -> current_state

(* Convert a state value to a string *)
let string_of_state (state: state) : string =
  match state with
  | Nothing -> ""
  | Busy -> "Busy"
  | Image_of_shadow_copies_deletion_attack -> "Image_of_shadow_copies_deletion_attack"
  | Possible_shadow_copies_deletion_attack -> "Possible_shadow_copies_deletion_attack"
  

(* Read events from a file and update the state accordingly until the end of the file is reached.
   Write the output to a file. *)
let rec loop (current_state: state) (in_channel: in_channel) (out_channel: out_channel) : unit =
  try
    let line = input_line in_channel in
    (* Parse the line as an event and update the state *)
    let event =
      match line with
      | "Event" -> Start
	  | "Image: C:\\Windows\\System32\\vssadmin.exe" -> Image_of_shadow_copies_deletion_attack
      | "CommandLine: vssadmin.exe delete shadows /all /quiet" -> Possible_shadow_copies_deletion_attack
      | _ -> Stop
    in
    let next_state = transition current_state event in
    output_string out_channel (string_of_state next_state ^ "\n");
    flush out_channel;
    loop next_state in_channel out_channel
  with End_of_file -> ()


(* Read the events from a file and start the ASTD simulation with an initial state of Idle.
   Write the output to a file. *)
let () =
  let in_channel = open_in "sysmonlogs.txt" in
  let out_channel = open_out "output.txt" in
  loop Nothing in_channel out_channel;
  close_in in_channel;
  close_out out_channel