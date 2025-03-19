local const = require('const')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(212, 128, 77))
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

  -- Health text
  love.graphics.setColor(love.math.colorFromBytes(62, 105, 88))
  love.graphics.print("Health: " .. self.health, self.x - 20, self.y - 15)
end

function mt:takeDamage(damage)
  self.health = self.health - damage
  if self.health <= 0 then
    print("Game Over!") -- TODO: Print to the screen
  end
end

return {
  new = function(x, y, world)
    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      health = 100,
    }, mt)
  end
}
