local luab64 = require'luab64'

local s0 = 'This is a string to encode!'
local s1 = 'This is a string to encode!!'
local s2 = 'This is a string to encode!!!'
local s3 = 'This is a string to encode!!!!'

--[[
local encfilter = luab64.encfilter()

local ltn12 = require'ltn12'

local src = ltn12.source.string(s)

local t = {}
local sink = ltn12.sink.table(t)

local filtersrc = ltn12.source.chain(src, encfilter)
ltn12.pump.all(filtersrc, sink)

print('enc: ' .. table.concat(t) .. ' :enc')
]]

for _,s in ipairs{ s0, s1, s2, s3 } do
  local r = luab64.encode(s)
  local z = luab64.decode(r)
  print('inp: ' .. s .. ' :inp')
  print('enc: ' .. r .. ' :enc')
  print('dec: ' .. z .. ' :dec')
  print() end

-- print('dec: ' .. luab64.decode'VGhpcyBpcyBhIHN0cmluZyB3ZSBzaGFsbCBlbmNvZGUhCg==' .. ' :dec')

-- print('dec: ' .. luab64.decode'Qm9uYW56YQ==' .. ' :dec')
