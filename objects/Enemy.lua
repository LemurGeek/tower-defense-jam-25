local const = require('const')
local GameState = require('GameState')
local anim8 = require('libs.anim8.anim8')
local Helpers = require('Helpers')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(1, 1, 1) -- Reset color
  self.animations.walk:draw(self.spriteSheet, self.x, self.y)
    
  -- Debug 
  -- love.graphics.setColor(love.math.colorFromBytes(98, 76, 60))
  -- love.graphics.rectangle('line', self.x, self.y, const.tilesize, const.tilesize)

  -- Only draw the health bar if recently damaged
  if self.showHealthBar then
    Helpers.drawHealthBar(self.health, self.x, self.y)
  end
end

function mt:takeDamage(damage)
  self.health = self.health - damage

  -- Show the health bar and reset the timer
  self.showHealthBar = true
  self.healthBarTimer = const.healthBarDisplayTime
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

  if dist < 1 then
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

  self.animations.walk:update(dt)

  -- Update the health bar timer
  if self.showHealthBar then
    self.healthBarTimer = self.healthBarTimer - dt
    if self.healthBarTimer <= 0 then
      self.showHealthBar = false
    end
  end
  return true
end

return {
  new = function(x, y)
    local world = GameState.getCurrent().world
    local target = world:findItemsByType("Base")

    local spriteIndex = math.random(2, 5)
    local spriteSheet = love.graphics.newImage("assets/enemy0" .. spriteIndex .. "-sheet.png")
    -- local spriteSheet = love.graphics.newImage("assets/enemy03-sheet.png")
    local grid = anim8.newGrid(40, 40, spriteSheet:getWidth(), spriteSheet:getHeight())
    local animations = {
      walk = anim8.newAnimation(grid('1-4', 1), 0.1)
    } 

    return setmetatable({
      x = x,
      y = y,
      r = const.tilesize / 4,
      type = "Enemy",
      spriteSheet = spriteSheet,
      animations = animations,
      world = world,
      health = 100,
      showHealthBar = false,
      healthBarTimer = 0,
      speed = 100,
      maxSpeed = 100,
      target = target,
      targetPathIndex = 2,
      damage = 20
    }, mt)
  end
}
