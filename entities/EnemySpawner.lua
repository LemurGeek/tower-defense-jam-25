local const = require('const')
local Enemy = require('Enemy')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(176, 58, 72))
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function mt:update(dt)
  -- print('x' .. self.x .. 'y' .. self.y)
  self.spawnTimer = self.spawnTimer - dt
  if self.spawnTimer <= 0 then
  GameState.getCurrent().world:add(Enemy.new(self.x + const.tilesize / 2, self.y + const.tilesize / 2))
    self.spawnTimer = 2
  end
end

return {
  new = function(x, y)
    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize,
      spawnTimer = 2
    }, mt)
  end
}
