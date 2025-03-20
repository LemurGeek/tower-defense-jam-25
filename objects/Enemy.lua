local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(176, 58, 72))
  love.graphics.circle("fill", self.x, self.y, self.r)

  love.graphics.setColor(love.math.colorFromBytes(62, 105, 88))
  love.graphics.print("Health: " .. self.health, self.x - 30, self.y - 40)
end

function mt:takeDamage(damage)
  self.health = self.health - damage
end

function mt:dealDamage(damage)
  self.target:takeDamage(self.damage)
end

function mt:speedDown()
  self.speed = self.speed * 0.5
end

function mt:update(dt)
  local pathPoints = GameState.getCurrent().level.pathPoints
  local target = pathPoints[self.targetPathIndex]
  local dirX, dirY = target.x - self.x, target.y - self.y
  local dist = math.sqrt(dirX^2 + dirY^2)

  if self.speed < self.maxSpeed then
    self.speed = self.speed + 0.05
  end

  if self.health <= 0 then
    self.world:remove(self)
    return false
  end

  if dist < 5 then
    self.targetPathIndex = self.targetPathIndex + 1
    if self.targetPathIndex > #pathPoints then
      self.world:remove(self)
      self:dealDamage() -- Enemy reached the base
      return false
    end
  else
    self.x = self.x + (dirX / dist) * self.speed * dt
    self.y = self.y + (dirY / dist) * self.speed * dt
  end

  return true
end

return {
  new = function(x, y)
    local world = GameState.getCurrent().world
    local target = world:findItemsByType("Base")

    return setmetatable({
      x = x,
      y = y,
      r = const.tilesize / 4,
      type = "Enemy",
      world = world,
      health = 100,
      speed = 100,
      maxSpeed = 100,
      target = target,
      targetPathIndex = 2,
      damage = 20
    }, mt)
  end
}
