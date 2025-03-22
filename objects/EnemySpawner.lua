local const = require('const')
local Enemy = require('Enemy')
local GameState = require('GameState')
local anim8 = require('libs.anim8.anim8')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(1, 1, 1) -- Reset color
  self.animations.spawner:draw(self.spriteSheet, self.x, self.y)

  -- love.graphics.setColor(love.math.colorFromBytes(176, 58, 72))
  -- love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function mt:update(dt)
  self.spawnTimer = self.spawnTimer - dt
  if self.spawnTimer <= 0 then
    local world = GameState.getCurrent().world
    GameState.getCurrent().world:add(Enemy.new(self.x, self.y))
    self.spawnTimer = 1
  end

  self.animations.spawner:update(dt)
end

return {
  new = function(x, y)

    local spriteSheet = love.graphics.newImage("assets/enemy-spawner-sheet.png")
    local grid = anim8.newGrid(40, 40, spriteSheet:getWidth(), spriteSheet:getHeight())
    local animations = {
      spawner = anim8.newAnimation(grid('1-4', 1), 0.2)
    } 
    
    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      type = "EnemySpawner",
      spriteSheet = spriteSheet,
      animations = animations,
      spawnTimer = 1,
    }, mt)
  end
}
