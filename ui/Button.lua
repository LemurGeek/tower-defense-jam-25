local const = require('const')
local GameState = require('GameState')

local mt = {}
mt.__index = mt

function mt:update(dt)
  -- Mouse position
  local mouseX, mouseY = love.mouse.getPosition()

  -- Check if the mouse is inside the button area
  if mouseX >= self.x and mouseX <= self.x + self.width and mouseY >= self.y and mouseY <= self.y + self.height then
    -- Hover color
    self.color = self.colorHover

    -- Check if the user clicks
    if love.mouse.isDown(1) then
        self.color = self.colorClick
        self.buttonClick = true
    else
      if self.buttonClick then
        -- Action if clicked
        self.action()
        self.buttonClick = false
      end
    end
  else
    -- Unhover color
    self.color = self.color
  end
end

function mt:draw()
  love.graphics.setColor(love.math.colorFromBytes(unpack(self.color)))
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

  love.graphics.setColor(1, 1, 1)  
  love.graphics.printf(self.text, self.x, self.y + self.height / 3, self.width, "center")
end

return {
  new = function(x, y, width, height, color, colorHover, colorClick, text, buttonClick, action)
    return setmetatable({
      typeUI = "Button",
      x = x,
      y = y,
      width = width,
      height = height,
      color = color,
      colorHover = colorHover,
      colorClick = colorClick,
      text = text,
      buttonClick = buttonClick, -- Boolean variable for click event, TODO: work on different logic
      action = action
    }, mt)
  end
}
