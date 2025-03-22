local const = require('const')
local GameState = require('GameState')
local Helpers = require('Helpers')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(212, 128, 77))
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

  -- Only draw the health bar if recently damaged
  if self.showHealthBar then
    Helpers.drawHealthBar(self.health, self.x, self.y)
  end
end

function mt:takeDamage(damage)
  self.health = self.health - damage
  if self.health <= 0 then
    GameState.getCurrent():trigger('base:kill')
  end

  -- Show the health bar and reset the timer
  self.showHealthBar = true
  self.healthBarTimer = const.healthBarDisplayTime
end

function mt:update(dt)
  -- Update the health bar timer
  if self.showHealthBar then
    self.healthBarTimer = self.healthBarTimer - dt
    if self.healthBarTimer <= 0 then
      self.showHealthBar = false
    end
  end
end

return {
  new = function(x, y, world)
    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      type = "Base",
      health = 1000,
      showHealthBar = false,
      healthBarTimer = 0
    }, mt)
  end
}
