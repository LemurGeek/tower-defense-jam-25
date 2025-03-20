local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:draw()
  if self.slowEffect then
    love.graphics.setColor(love.math.colorFromBytes(139, 92, 147))
  else
      love.graphics.setColor(love.math.colorFromBytes(92, 139, 147))
  end
  love.graphics.circle("fill", self.x, self.y, 20)
end

function mt:update(dt)

end

return {
  new = function(x, y, towerType)
    local world = GameState.getCurrent().world

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
