local GameState = require('GameState')
local Level = require('LevelManager')
local World = require('World')

local mt = {}
mt.__index = mt

function mt:update(dt)
  for _, item in ipairs(self.world.items) do
    if item.update then
      item:update(dt)
    end
  end
end

function mt:draw()
  for _, item in ipairs(self.world.items) do
    item:draw()
  end
end

-- Trigger function let you pass some "events" to the game state so a given entity need not to worry how to
-- deal with some situation.
function mt:trigger(event) -- , actor, data)
  if event == 'base:kill' then
    GameState.setCurrent('Dead')
  end
end

return {
  new = function()
    local state = setmetatable({ name = 'play_state' }, mt)

    -- Every time we instantiate the gamestate we also have a new instance of World and Level.
    state.world = World.new()
    state.level = Level.new('level_1', state)

    return state
  end
}
