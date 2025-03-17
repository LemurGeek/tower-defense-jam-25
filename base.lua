Base = {}
Base.__index = Base

function Base:new(x, y)
  local obj = {
    x = x, y = y,
    health = 100
  }
  setmetatable(obj, Base)
  return obj
end

function Base:takeDamage(damage)
    self.health = self.health - damage
    if self.health <= 0 then
      print("Game Over!") -- TODO: Print to the screen
    end
end

function Base:draw()
  love.graphics.setColor(love.math.colorFromBytes(212, 128, 77))
  love.graphics.rectangle("fill", self.x - 20, self.y - 20, 40, 40)

  -- Health text
  love.graphics.setColor(love.math.colorFromBytes(62, 105, 88))
  love.graphics.print("Health: " .. self.health, self.x - 30, self.y - 40)
end

return Base
