local mt = {}
mt.__index = mt

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(unpack(self.color)))
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return {
  new = function(x, y, width, height, color)
    return setmetatable({
      typeUI = "Box",
      x = x,
      y = y,
      width = width,
      height = height,
      color = color
    }, mt)
  end
}
