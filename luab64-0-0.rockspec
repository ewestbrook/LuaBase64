package = "luab64"
version = "0-0"

source = {
  url = "https://github.com/ewestbrook/luab64" }

dependencies = { "lua >= 5.1, < 5.4" }

description = {
  summary = 'luab64: Light and Fast LTN12-compatible Base64 Encoding and Decoding in Lua'
  , homepage = "https://github.com/ewestbrook/luab64"
  , license = 'MIT' }

build = {
  type = 'builtin'

  , modules = {

    luab64 = 'src/luab64.lua'

    , ['luab64.c'] = {
      'src/luab64.c'
      , 'src/b64enc.c'
      , 'src/b64dec.c' }}}
