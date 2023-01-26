
let event_string = "Event"


let firstLine, secondLine, thirdLine, fourthLine = 
let file = open_in "guard.txt" in
  let firstLine = input_line file in
  let secondLine = input_line file in
  let thirdLine = input_line file in
  let fourthLine = input_line file in
  close_in file;
  firstLine, secondLine, thirdLine, fourthLine

let () = print_endline "\n  Monitoring in progress... \n"

(* Define the states of the ASTD using a variant type *)
type state =
  | Nothing
  | Busy
  | Low
  | Medium
  | High
  | Critical
  

(* Define the events that can trigger transitions between states using another variant type *)
type event =
  | Start
  | Stop
  | Low
  | Medium
  | High
  | Critical

(* Define a function that represents the transitions between states.
   This function takes a current state and an event as input, and returns the next state. *)
let transition (current_state: state) (event: event) : state =
  match current_state, event with
  | Nothing, Start -> Busy
  | Busy, Stop -> Nothing
  | _, Low -> Low
  | Low, Stop -> Low
  | Low, Start -> Busy
  | Low, Medium -> Medium
  | Medium, Stop -> Medium
  | Medium, Start -> Busy
  | Medium, High -> High
  | High, Stop -> High
  | High, Start -> Busy
  | High, Critical -> Critical
  | Critical, Stop -> Nothing
  | _ -> current_state

(* Convert a state value to a string *)
let string_of_state (state: state) : string =
  match state with
  | Nothing -> ""
  | Busy -> "Busy"
  | Low -> "Low"
  | Medium -> "Medium"
  | High -> "High"
  | Critical -> "Critical"

(* Read events from a file and update the state accordingly until the end of the file is reached.
   Write the output to a file. *)
let rec loop (current_state: state) (in_channel: in_channel) (out_channel: out_channel) : unit =
  try
    let line = input_line in_channel in
    (* Parse the line as an event and update the state *)
    let event = 
      if line = event_string then Start
      else if line = firstLine then Low
      else if line = secondLine then Medium
      else if line = thirdLine then High
      else if line = fourthLine then Critical
      else Stop
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