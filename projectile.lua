Projectile = {}
Projectile.__index = Projectile

function Projectile:new(x, y, target)
    local obj = {
        x = x, y = y,
        speed = 200,
        target = target
    }
    setmetatable(obj, Projectile)
    return obj
end

function Projectile:update(dt)
    local dirX, dirY = self.target.x - self.x, self.target.y - self.y
    local dist = math.sqrt(dirX^2 + dirY^2)

    if dist < 5 then
        self.target.health = self.target.health - 20
        return false -- Remove projectile
    end

    self.x = self.x + (dirX / dist) * self.speed * dt
    self.y = self.y + (dirY / dist) * self.speed * dt
    return true
end

function Projectile:draw()
    love.graphics.setColor(love.math.colorFromBytes(224, 200, 114))
    love.graphics.circle("fill", self.x, self.y, 5)
end

return Projectile