module LuaL = Lua_api.LuaL
module Lua = Lua_api.Lua
module Sdl = Tsdl.Sdl

let () =
  let ls = LuaL.newstate () in
  LuaL.openlibs ls;
  LuaL.register ls (Some "lib") [];
  if LuaL.dofile ls "test.lua" then print_endline "ok" else print_endline "not ok";
  Sdl.init Sdl.Init.(video + events) |> ignore;
  match Sdl.create_window_and_renderer ~w:500 ~h:300 Sdl.Window.mouse_focus with
  | Ok (_w, r) ->
    let quit = ref false in
    (* event handling is only needed to be able to more nicely close the window
       again *)
    let e = Sdl.Event.create () in
    while not !quit do
      if Sdl.poll_event (Some e)
      then (
        match Sdl.Event.(enum (get e typ)) with
        | `Quit -> quit := true
        | _ -> ());
      Sdl.set_render_draw_color r 20 20 20 200 |> ignore;
      Sdl.render_clear r |> ignore;
      Sdl.render_present r
    done
  | Error (`Msg e) ->
    print_endline e;
    exit 1
;;
