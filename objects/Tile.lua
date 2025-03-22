local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  if self.empty then 
    love.graphics.setColor(love.math.colorFromBytes(98, 76, 60))
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
  end
end

function mt:mousepressed(x, y, button)
  local levelUI = GameState.getCurrent().levelUI

  if button == 1 and levelUI.towerSelected then
    -- Check if the current tile was clicked
    if x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h and self.empty then
      -- Calculate the center coordinates of the tile
      local centerX = self.x + self.w / 2
      local centerY = self.y + self.h / 2

      GameState.getCurrent():trigger('tower:add', self, {x = centerX, y = centerY, type = levelUI.selectedTower})
      
      self.empty = false
      levelUI.towerSelected = not levelUI.towerSelected
    end
  end
end

return {
  new = function(x, y)
    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      empty = true,
      type = "Tile"
    }, mt)
  end
}
