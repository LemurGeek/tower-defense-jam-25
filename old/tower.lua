Tower = {}
Tower.__index = Tower

Projectile = require("Projectile")

-- Creates a new tower with position, range, fire rate, cooldown, and damage.
function Tower:new(x, y)
    local obj = {
        x = x, y = y,
        range = 100,
        fireRate = 0.5,
        cooldown = 0,
        damage = 15,
        slowEffect = false,
    }
    setmetatable(obj, Tower)
    return obj
end

-- Updates the tower's cooldown and triggers attack if ready.
function Tower:update(dt, enemies, projectiles)
    self.cooldown = self.cooldown - dt
    if self.cooldown <= 0 then
        self:attack(enemies, projectiles)
    end
end

-- Checks enemies in range and creates projectiles to attack.
function Tower:attack(enemies, projectiles)
    for _, enemy in pairs(enemies) do
        local dist = math.sqrt((enemy.x - self.x)^2 + (enemy.y - self.y)^2)
        if dist < self.range then
            local newProjectile = Projectile:new(self.x, self.y, enemy, self.damage)
            if self.slowEffect then
                newProjectile.slowEffect = true
            end
            table.insert(projectiles, newProjectile)
            self.cooldown = self.fireRate
            break
        end
    end
end

-- Creates a tower that slows enemies without dealing damage.
function Tower:createSlowTower(x, y)
    local slowTower = Tower:new(x, y)
    slowTower.slowEffect = true
    slowTower.damage = 0
    return slowTower
end

-- Draws the tower, changing color if it has a slow effect.
function Tower:draw()
    if self.slowEffect then
        love.graphics.setColor(love.math.colorFromBytes(139, 92, 147))
    else
        love.graphics.setColor(love.math.colorFromBytes(92, 139, 147))
    end
    love.graphics.circle("fill", self.x, self.y, 20)
end

return Tower
