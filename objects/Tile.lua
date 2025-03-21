local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(98, 76, 60))
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

function mt:update(dt)
  if love.mouse.isDown(1) and self.levelUI.towerSelected then  -- Left mouse click
    local x, y = love.mouse.getPosition()
    print("Mouse clicked at:", x, y)
    print("Tile coords at:", self.x, self.y)
    -- TODO: Check if the coords are within the tile and create the torrer there 
  end
end

return {
  new = function(x, y)
    -- TODO: for some reason is throwing an error here but is the same setup 
    -- as Enemy.lua, idk why is not working here.

    local world = GameState.getCurrent().world
    local levelUI = GameState.getCurrent().levelUI

    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      type = "Tile",
      world = world,
      lvlUI = levelUI
    }, mt)
  end
}
