module LuaL = Lua_api.LuaL
module Lua = Lua_api.Lua
module Sdl = Tsdl.Sdl

let lua_foo ls =
  let n = Lua.tointeger ls (-1) in
  Lua.pushinteger ls (n * 17);
  1
;;

let () =
  let ls = LuaL.newstate () in
  LuaL.openlibs ls;
  LuaL.register ls (Some "lib") [ "foo", lua_foo ];
  if LuaL.dofile ls "test.lua" then print_endline "ok" else print_endline "not ok";
  Sdl.init Sdl.Init.(video + events) |> ignore;
  match Sdl.create_window_and_renderer ~w:500 ~h:300 Sdl.Window.mouse_focus with
  | Ok (_w, r) ->
    while true do
      Sdl.set_render_draw_color r 20 20 20 200 |> ignore;
      Sdl.render_clear r |> ignore;
      Sdl.render_present r
    done
  | Error (`Msg e) ->
    print_endline e;
    exit 1
;;
