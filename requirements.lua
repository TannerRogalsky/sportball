-- Helper assignments and erata
g = love.graphics
GRAVITY = 700
math.tau = math.pi * 2

-- The pixel grid is actually offset to the center of each pixel. So to get clean pixels drawn use 0.5 + integer increments.
g.setPointSize(2.5)
g.setPointStyle("rough")
math.randomseed(os.time())
function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end
function math.clamp(low, n, high) return math.min(math.max(low, n), high) end
function math.attenuate(n, d)
  if n >= d then return n - d
  elseif n <= -d then return n + d
  else return 0 end
end
function table.sample(t) return t[math.random(#t)] end
function pointInCircle(circle, point) return (point.x-circle.x)^2 + (point.y - circle.y)^2 < circle.radius^2 end
function string:split(sep) return self:match((self:gsub("[^"..sep.."]*"..sep, "([^"..sep.."]*)"..sep))) end
globalID = 0
function generateID() globalID = globalID + 1 return globalID end
function is_func(f) return type(f) == "function" end
function is_num(n) return type(n) == "number" end
function is_string(s) return type(s) == "string" end

-- Put any game-wide requirements in here
Vector = require 'lib/HardonCollider/vector-light'
require 'lib/middleclass'
Stateful = require 'lib/stateful'
skiplist = require "lib/skiplist"
HC = require 'lib/HardonCollider'
inspect = require 'lib/inspect'
require 'lib/AnAL'
-- require 'lib/LoveFrames'
cron = require 'lib/cron'
COLORS = require 'lib/colors'
tween = require 'lib/tween'
beholder = require 'lib/beholder'
Grid = require 'lib/grid'

require 'base'
require 'game'
require 'player'
require 'level'
require 'trap'
require 'powerup'
require 'obstruction'
require 'controlled_object'
require 'ball_object'
require 'goal_object'

require 'direction'

local function require_all(directory)
  local lfs = love.filesystem
  for index,filename in ipairs(lfs.getDirectoryItems(directory)) do
    local file = directory .. "/" .. filename
    if lfs.isFile(file) and file:match("%.lua$") then
      require(file:gsub("%.lua", ""))
    elseif lfs.isDirectory(file) then
      require_all(file)
    end
  end
end
require_all("states")
