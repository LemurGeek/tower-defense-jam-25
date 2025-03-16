Base = require("base")
Tower = require("tower")
Projectile = require("Projectile")
Enemy = require("enemy")
path = require("path")

-- NOTE: Tables are like js objects, but also work as arrays it depends how are created. Check this for speedrun how to code in Lua: https://learnxinyminutes.com/lua/ 

-- Load function is called once at the beginning of the game, this is where we initialize our variables
function love.load()
  enemies = {}
  towers = {Tower:new(150, 150)}
  projectiles = {}
  spawnTimer = 2
  base = Base:new(path[#path].x, path[#path].y) -- Base at the end of the path (TODO: Imrpove this logic later)
end

-- Update function is called every frame, dt is the time passed since the last frame. We use this function to update our variables and logic.
function love.update(dt)
  spawnTimer = spawnTimer - dt
  if spawnTimer <= 0 then
      table.insert(enemies, Enemy:new())
      spawnTimer = 2
  end

  -- Update enemies
  for i = #enemies, 1, -1 do
      if not enemies[i]:update(dt) then
          base:takeDamage(10) -- Enemy reached the end, reduce base health
          table.remove(enemies, i)
      end
  end

  -- Update towers
  for _, tower in ipairs(towers) do
      tower:update(dt, enemies)
  end

  -- Update projectiles -- TODO: Maybe move this logic to tower.lua
  for i = #projectiles, 1, -1 do
      if not projectiles[i]:update(dt) then
          table.remove(projectiles, i)
      end
  end
end

-- Draw function is called every frame, this is where we draw things on the screen, based on our variables and logic.
function love.draw()
  love.graphics.setBackgroundColor( love.math.colorFromBytes(43, 40, 33) )
  
  base:draw()

  for _, enemy in ipairs(enemies) do
      enemy:draw()
  end

  for _, tower in ipairs(towers) do
      tower:draw()
  end

  for _, projectile in ipairs(projectiles) do
      projectile:draw()
  end
end
