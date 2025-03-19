local const = require('const')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(98, 76, 60))
  love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

return {
  new = function(x, y, world)
    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize
    }, mt)
  end
}
