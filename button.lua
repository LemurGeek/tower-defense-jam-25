Button = {}
Button.__index = Button

-- Turn into parameters
function Button:new(id, x, y, width, height, color, colorHover, colorClick, text, buttonClick)
    local obj = { 
        id = id,
        x = x, 
        y = y,
        width = width,
        height = height,
        color = color,
        colorHover = colorHover,
        colorClick = colorClick,
        text = text,
        buttonClick = buttonClick -- Boolean variable for click event, TODO: work on different logic
    }
    setmetatable(obj, Button)
    return obj
end

function Button:update(action)
    -- Mouse position
    local mouseX, mouseY = love.mouse.getPosition()

    -- Verificar si el mouse está dentro del área del botón
    if mouseX >= self.x and mouseX <= self.x + self.width and mouseY >= self.y and mouseY <= self.y + self.height then
        -- Cambiar el color si el mouse está encima
        self.color = self.colorHover

        -- Verificar si el usuario hace clic
        if love.mouse.isDown(1) then
            self.color = self.colorClick
            self.buttonClick = true
        else
            if self.buttonClick then
                -- Acción cuando se hace clic (si es necesario)
                action()
                self.buttonClick = false
            end
        end
    else
        -- Restaurar el color cuando el mouse no está encima
        self.color = self.color
    end
end

function Button:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setFont(font)
    love.graphics.setColor(1, 1, 1)  
    love.graphics.printf(self.text, self.x, self.y + self.height / 4, self.width, "center")
end


return Button