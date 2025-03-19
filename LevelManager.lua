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

-- Helper function to calculate the distance between two points
local function distance(p1, p2)
  local dx, dy = p1.x - p2.x, p1.y - p2.y
  return math.sqrt(dx * dx + dy * dy)
end

-- Function to sort path points by proximity
local function sortPathPoints(pathPoints)
  local sorted = {}
  local visited = {}
  local current = table.remove(pathPoints, 1) -- Start with the first point
  sorted[#sorted + 1] = current
  visited[current] = true

  while #pathPoints > 0 do
    -- Find the nearest point to the current point
    local nearestIndex, nearestDistance = nil, math.huge
    for i, point in ipairs(pathPoints) do
      if not visited[point] then
        local dist = distance(current, point)
        if dist < nearestDistance then
          nearestIndex, nearestDistance = i, dist
        end
      end
    end

    -- Add the nearest point to the sorted list and remove it from the original list
    current = table.remove(pathPoints, nearestIndex)
    sorted[#sorted + 1] = current
    visited[current] = true
  end

  return sorted
end

return {
  new = function(lvl_name, game_state)
    local lvl = setmetatable({ columns = 20, tiles = {}, pathPoints = {} }, mt)

    lvl.data = require('levels.' .. lvl_name)

    for i, v in ipairs(lvl.data) do
      local x, y = (i-1) % lvl.columns * const.tilesize, math.floor((i-1) / lvl.columns) * const.tilesize

      if v == 2 then 
        lvl.pathPoints[#lvl.pathPoints + 1] = { 
          x = x + const.tilesize / 2, 
          y = y + const.tilesize / 2 
        }
      end

      if TILES_TYPES[v] then
        game_state.world:add( TILES_TYPES[v].new(x, y, game_state) )
      end
    end

    -- Sort the path points by proximity
    lvl.pathPoints = sortPathPoints(lvl.pathPoints)

    return lvl
  end
}
