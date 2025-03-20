local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(92, 139, 147))

  if self.towerType == 'slow' then
    love.graphics.setColor(love.math.colorFromBytes(93, 114, 117))
  end

  love.graphics.circle("fill", self.x, self.y, 20)
end

function mt:update(dt , enemies, projectiles)
  self.cooldown = self.cooldown - dt
  if self.cooldown <= 0 then
      self:attack(enemies, projectiles)
  end
end

-- Checks enemies in range and creates projectiles to attack.
function mt:attack(enemies, projectiles)
  for _, enemy in pairs(enemies) do
    local dist = math.sqrt((enemy.x - self.x)^2 + (enemy.y - self.y)^2)
    if dist < self.range then
      local newProjectile = Projectile:new(self.x, self.y, enemy, self.damage)
      if self.slowEffect then
        newProjectile.slowEffect = true
      end
      table.insert(projectiles, newProjectile)
      self.cooldown = self.fireRate
      break
    end
  end
end

return {
  new = function(x, y, towerType)
    local world = GameState.getCurrent().world

    if(towerType == 'slow') then
      return setmetatable({
        x = x,
        y = y,
        w = const.tilesize,
        h = const.tilesize,
        type = "Tower",
        towerType = 'slow',
        world = world,
        range = 100,
        fireRate = 0.5,
        cooldown = 0,
        damage = 2,
        slowEffect = true,
      }, mt)
    end

    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      type = "Tower",
      towerType = 'normal',
      world = world,
      range = 100,
      fireRate = 0.5,
      cooldown = 0,
      damage = 15,
      slowEffect = false,
    }, mt)
  end
}
