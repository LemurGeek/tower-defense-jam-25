Projectile = {}
Projectile.__index = Projectile

-- Creates a new projectile with position, speed, target, damage, and slow effect flag.
function Projectile:new(x, y, target, damage)
    local obj = {
        x = x, y = y,
        speed = 200,
        target = target,
        damage = damage,
        slowEffect = false,
    }
    setmetatable(obj, Projectile)
    return obj
end

-- Updates projectile position and checks for collision with target.
-- Returns false when the projectile reaches the target.
function Projectile:update(dt)
    -- Calculate direction and distance to target.
    local dirX, dirY = self.target.x - self.x, self.target.y - self.y
    local dist = math.sqrt(dirX^2 + dirY^2)

    -- If close enough to target, apply damage and slow effect, then stop projectile.
    if dist < 5 then
        self.target:takeDamage(self.damage)
        if self.slowEffect then
            self.target:speedDown()
        end
        return false
    end

    -- Move projectile towards the target.
    self.x = self.x + (dirX / dist) * self.speed * dt
    self.y = self.y + (dirY / dist) * self.speed * dt
    return true
end

-- Draws the projectile as a small circle.
function Projectile:draw()
    love.graphics.setColor(love.math.colorFromBytes(224, 200, 114))
    love.graphics.circle("fill", self.x, self.y, 5)
end

return Projectile