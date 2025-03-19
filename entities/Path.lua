local const = require('const')

local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(227, 207, 180))
  love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

  -- -- Debbug

  font = love.graphics.newFont(10)  -- Set font size to 30
  love.graphics.setFont(font) 
  love.graphics.setColor(love.math.colorFromBytes(62, 105, 88))
  love.graphics.print("X - Y: " .. self.x .. ' - ' .. self.y , self.x, self.y)
end

return {
  new = function(x, y)
    return setmetatable({
      x = x,
      y = y,
      w = const.tilesize,
      h = const.tilesize
    }, mt)
  end
}
