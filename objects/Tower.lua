local const = require('const')
local GameState = require('GameState')
local Projectile = require('Projectile')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(92, 139, 147))

  if self.towerType == 'slow' then
    love.graphics.setColor(love.math.colorFromBytes(93, 114, 117))
  end

  love.graphics.circle("fill", self.x, self.y, 20)
end

function mt:update(dt)
  self.cooldown = self.cooldown - dt
  if self.cooldown <= 0 then
      self:attack()
  end
end

-- Checks enemies in range and creates projectiles to attack.
function mt:attack()
  enemies = self.world:findItemsByType("Enemy")
  projectiles = self.world:findItemsByType("Projectile")

  if #enemies == 0 then
    return
  end

  if(self.towerType == 'slow') then
    self:attackAll()
  else 
    self:attackClosest()
  end

end

local function distance(a, b)
  return math.sqrt((a.x - b.x)^2 + (a.y - b.y)^2)
end

-- Attacks all enemies within range
function mt:attackAll()
  local enemies = self.world:findItemsByType("Enemy")
  for _, enemy in ipairs(enemies) do
    if distance(self, enemy) < self.range then
      self.world:add(Projectile.new(self.x, self.y, enemy, self.damage, self.slowEffect))
      self.cooldown = self.fireRate
    end
  end
end

-- Attacks the closest enemy within range
function mt:attackClosest()
  local enemies = self.world:findItemsByType("Enemy")
  table.sort(enemies, function(a, b)
    return distance(self, a) < distance(self, b)
  end)
  local closest = enemies[1]
  if closest and distance(self, closest) < self.range then
    self.world:add(Projectile.new(self.x, self.y, closest, self.damage, self.slowEffect))
    self.cooldown = self.fireRate
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
        fireRate = 1.6,
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
