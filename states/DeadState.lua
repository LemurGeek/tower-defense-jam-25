local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:update(dt)
  if love.keyboard.isDown('return') then
    GameState.setCurrent('Play')
  end
end

function mt:draw()
  love.graphics.print('game over\npress [enter] to restart', 100, 100)
end

-- This gamestate ignores any events:
function mt:trigger()
end

-- This gamestate ignores any events:
function mt:mousepressed()
end

return {
  new = function()
    return setmetatable({ name = 'dead_state' }, mt)
  end
}
