module LuaL = Lua_api.LuaL
module Lua = Lua_api.Lua

let () =
  let ls = LuaL.newstate () in
  LuaL.openlibs ls;
  (* this seems to be the problem *)
  LuaL.register ls (Some "lib") [];
  Gc.full_major ();
  Lua.pushstring ls "foobar";
  print_endline "bye"
;;
