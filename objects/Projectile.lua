local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(224, 200, 114))
  love.graphics.circle("fill", self.x, self.y, 5)
end

function mt:update(dt)
  -- Calculate direction and distance to target.
  local dirX, dirY = self.target.x - self.x, self.target.y - self.y
  local dist = math.sqrt(dirX^2 + dirY^2)

  -- If close enough to target, apply damage and slow effect, then stop projectile.
  if dist < 5 then
      self.target:takeDamage(self.damage)
      if self.slowEffect then
          self.target:speedDown()
      end
      self.world:remove(self)
      return false
  end

  -- Move projectile towards the target.
  self.x = self.x + (dirX / dist) * self.speed * dt
  self.y = self.y + (dirY / dist) * self.speed * dt
  return true
end


return {
  new = function(x, y, target, damage, slowEffect)
    local world = GameState.getCurrent().world

    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      type = "Projectile",
      world = world,
      speed = 200,
      target = target,
      damage = damage,
      slowEffect = slowEffect,
    }, mt)
  end
}
