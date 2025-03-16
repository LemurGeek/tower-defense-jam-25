Tower = {}
Tower.__index = Tower

Projectile = require("Projectile")

function Tower:new(x, y)
    local obj = {
        x = x, y = y,
        range = 100,
        fireRate = 0.5,
        cooldown = 0,
        damage = 15
    }
    setmetatable(obj, Tower)
    return obj
end

function Tower:update(dt, enemies)
    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        for _, enemy in pairs(enemies) do
            local dist = math.sqrt((enemy.x - self.x)^2 + (enemy.y - self.y)^2)
            if dist < self.range then
                self.cooldown = self.fireRate
                table.insert(projectiles, Projectile:new(self.x, self.y, enemy, self.damage))
                break
            end
        end
    end
end

function Tower:draw()
    love.graphics.setColor(love.math.colorFromBytes(92, 139, 147))
    love.graphics.circle("fill", self.x, self.y, 15)
end

return Tower