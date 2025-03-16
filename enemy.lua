path = require("path")

Enemy = {}
Enemy.__index = Enemy


function Enemy:new()
    local obj = {
        x = path[1].x, y = path[1].y,
        speed = 50,
        health = 100,
        targetIndex = 2
    }
    setmetatable(obj, Enemy)
    return obj
end

function Enemy:update(dt)
    local target = path[self.targetIndex]
    local dirX, dirY = target.x - self.x, target.y - self.y
    local dist = math.sqrt(dirX^2 + dirY^2)

    if not target then 
      return false -- Enemuy reached the base
    end

    if dist < 5 then
        self.targetIndex = self.targetIndex + 1
        if self.targetIndex > #path then
            -- Enemy reached the end (reduce player health)
            return false
        end
    else
        self.x = self.x + (dirX / dist) * self.speed * dt
        self.y = self.y + (dirY / dist) * self.speed * dt
    end
    return true
end

function Enemy:draw()
    love.graphics.setColor(love.math.colorFromBytes(176, 58, 72))
    love.graphics.circle("fill", self.x, self.y, 10)
end

return Enemy