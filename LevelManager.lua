local const = require('const')
local ENTITIES_FOLDER = 'entities.'

local mt = {}
mt.__index = mt

local TILES_TYPES = {
  [0] = require(ENTITIES_FOLDER .. 'Tile'),
  [1] = require(ENTITIES_FOLDER .. 'Base'),
  [2] = require(ENTITIES_FOLDER .. 'Path'),
  [3] = require(ENTITIES_FOLDER .. 'EnemySpawner'),
  [4] = require(ENTITIES_FOLDER .. 'Wall'),
}

return {
  new = function(lvl_name, game_state)
    local lvl = setmetatable({ columns = 20, tiles = {}, pathPoints = {} }, mt)

    lvl.data = require('levels.' .. lvl_name)

    for i, v in ipairs(lvl.data) do
      local x, y = (i-1) % lvl.columns * const.tilesize, math.floor((i-1) / lvl.columns) * const.tilesize

      if v == 2 then 
        lvl.pathPoints[#lvl.pathPoints + 1] = { x = x - const.tilesize / 2 , y = y - const.tilesize / 2 }
      end

      -- for _, point in ipairs(lvl.pathPoints) do
      --     print(point.x, point.y)
      -- end

      if TILES_TYPES[v] then
        game_state.world:add( TILES_TYPES[v].new(x, y, game_state) )
      end
    end

    return lvl
  end
}
