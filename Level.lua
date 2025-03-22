local const = require('const')
local PathFinding = require('Pathfinding')

local mt = {}
mt.__index = mt

local TILES_TYPES = {
  [0] = require('objects.Tile'),
  [1] = require('objects.Base'),
  [2] = require('objects.Path'),
  [3] = require('objects.EnemySpawner'),
  [4] = require('objects.Wall'),
}

return {
  new = function(lvl_name, game_state)
    local lvl = setmetatable({ columns = 20, pathPoints = {}, waves = {} }, mt)

    lvl.data = require('levels.' .. lvl_name)

    for i, v in ipairs(lvl.data) do
      local x, y = (i-1) % lvl.columns * const.tilesize, math.floor((i-1) / lvl.columns) * const.tilesize

      if v == 2 then 
        lvl.pathPoints[#lvl.pathPoints + 1] = { 
          x = x, 
          y = y 
        }
      end

      if TILES_TYPES[v] then
        game_state.world:add( TILES_TYPES[v].new(x, y, game_state) )
      end
    end

    -- Sort the path points by proximity
    lvl.pathPoints = PathFinding.sortPathPoints(lvl.pathPoints)

    return lvl
  end
}
