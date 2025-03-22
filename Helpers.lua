-- This module is responsible for handing current game state. 
local Helpers = {}

function Helpers.drawHealthBar(health, x, y)
  -- Draw health bar background
  love.graphics.setColor(0.5, 0.5, 0.5) -- Gray color
  love.graphics.rectangle('fill', x, y - 10, 40, 5)

  -- Draw health bar foreground
  local healthPercentage = health / 100
  love.graphics.setColor(0, 1, 0) -- Green color
  love.graphics.rectangle('fill', x, y - 10, 40 * healthPercentage, 5)

  love.graphics.setColor(1, 1, 1) -- Reset color
end

return Helpers
