path = require("path")

Enemy = {}
Enemy.__index = Enemy


function Enemy:new(target)
  local obj = {
    x = path[1].x, y = path[1].y,
    speed = 100,
    maxSpeed = 100,
    health = 100,
    targetIndex = 2,
    target = target,
    damage = 20
  }
  setmetatable(obj, Enemy)
  return obj
end

function Enemy:takeDamage(damage)
  self.health = self.health - damage
  self.speed = self.speed - damage
end

function Enemy:dealDamage()
  self.target:takeDamage(self.damage)
end

function Enemy:update(dt)
  local target = path[self.targetIndex]
  local dirX, dirY = target.x - self.x, target.y - self.y
  local dist = math.sqrt(dirX^2 + dirY^2)

  if self.speed < self.maxSpeed then
    self.speed = self.speed + 0.05
  end

  if self.health <= 0 then
    return false
  end

  if dist < 5 then
    self.targetIndex = self.targetIndex + 1
    if self.targetIndex > #path then
      self:dealDamage() -- Enemy reached the base
      return false
    end
  else
    self.x = self.x + (dirX / dist) * self.speed * dt
    self.y = self.y + (dirY / dist) * self.speed * dt
  end
  return true
end

function Enemy:draw()
  love.graphics.setColor(love.math.colorFromBytes(176, 58, 72))
  love.graphics.circle("fill", self.x, self.y, 10)

  love.graphics.setColor(love.math.colorFromBytes(62, 105, 88))
  love.graphics.print("Health: " .. self.health, self.x - 30, self.y - 40)
end

return Enemy