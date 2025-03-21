local const = require('const')
local GameState = require('GameState')
local Tower = require("Tower")

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(98, 76, 60))
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

function mt:update(dt)
  local mouseX, mouseY = love.mouse.getPosition()
  local levelUI = GameState.getCurrent().levelUI

  if mouseX >= self.x and mouseX <= self.x + self.w and mouseY >= self.y and mouseY <= self.y + self.h then
      if love.mouse.isDown(1) and levelUI.towerSelected then
        self.buttonClick = true
      else
        if self.buttonClick then
          self:tileClicked(mouseX, mouseY) -- gets the tile click could be a return and return x and y
          self.buttonClick = false
          levelUI.towerSelected = not levelUI.towerSelected
        end
      end
  end
end


function mt:tileClicked(x, y) -- Gets the snapped tile clicked
  local gridX = math.floor(x / self.h) + 1
  local gridY = math.floor(y / self.h) + 1

  -- Check if it's within the grid and empty
  if (gridX > 0 and gridX <= self.w) and (gridY > 0 and gridY <= self.h) then
    local snappedX = (gridX * self.h) - (self.h / 2)
    local snappedY = (gridY * self.h) - (self.h / 2)
    GameState.getCurrent().world:add(Tower.new(snappedX, snappedY, "normal")) -- Action on the tile could be something different
  end
end

return {
  new = function(x, y)
    -- TODO: for some reason is throwing an error here but is the same setup 
    -- as Enemy.lua, idk why is not working here.


    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      type = "Tile"
    }, mt)
  end
}
