gridSize = 40 -- Each tile is 40x40 pixels
gridWidth = 20 -- Number of columns
gridHeight = 20 -- Number of rows

grid = {}

Base = require("base")
Tower = require("tower")
Projectile = require("Projectile")
Enemy = require("enemy")
Button = require("button")
path = require("path")

-- NOTE: Tables are like js objects, but also work as arrays it depends how are created. Check this for speedrun how to code in Lua: https://learnxinyminutes.com/lua/ 

-- Load function is called once at the beginning of the game, this is where we initialize our variables
function love.load()
  enemies = {}
  -- towers = {Tower:new(150, 150)}
  towers = {}
  projectiles = {}
  spawnTimer = 2
  base = Base:new(path[#path].x, path[#path].y) -- Base at the end of the path (TODO: Improve this logic later)
  buttons = {Button:new()}
  font = love.graphics.newFont(20)  -- Font

  towerSelected = false;

  -- Grid System
  for y = 1, gridHeight do
    grid[y] = {}
    for x = 1, gridWidth do
      grid[y][x] = nil -- Empty by default
    end
  end
end

-- Update function is called every frame, dt is the time passed since the last frame. We use this function to update our variables and logic.
function love.update(dt)
  spawnTimer = spawnTimer - dt
  if spawnTimer <= 0 then
    table.insert(enemies, Enemy:new(base))
    spawnTimer = 2
  end

  -- Update enemies
  for i = #enemies, 1, -1 do
    if not enemies[i]:update(dt) then
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

  -- Update buttons click on a turret, become draggable, click again to place tower, Bloons style
  for _, button in ipairs(buttons) do
    button:update()
    if button.buttonClick then
      towerSelected = not towerSelected
    end 
  end
end

function love.mousepressed(x, y, button)
  if button == 1 and towerSelected then -- Left mouse click
    local gridX = math.floor(x / gridSize) + 1
    local gridY = math.floor(y / gridSize) + 1

    -- Check if it's within the grid and empty
    if (gridX > 0 and gridX <= gridWidth) and (gridY > 0 and gridY <= gridHeight) and not grid[gridY][gridX] then
      local snappedX = (gridX * gridSize) - (gridSize / 2)
      local snappedY = (gridY * gridSize) - (gridSize / 2)

      -- Create and store the tower
      local newTower = Tower:new(snappedX, snappedY)
      table.insert(towers, newTower)
      grid[gridY][gridX] = newTower -- Mark tile as occupied
    end

    towerSelected = not towerSelected
  end
end

-- Draw function is called every frame, this is where we draw things on the screen, based on our variables and logic.
function love.draw()
  love.graphics.setBackgroundColor( love.math.colorFromBytes(43, 40, 33) )

  base:draw()

  -- Draw grid
  love.graphics.setColor(0.8, 0.8, 0.8) -- Light gray grid
  for y = 0, gridHeight - 1 do
    for x = 0, gridWidth - 1 do
      love.graphics.rectangle("line", x * gridSize, y * gridSize, gridSize, gridSize)
    end
  end

  for _, enemy in ipairs(enemies) do
    enemy:draw()
  end

  for _, tower in ipairs(towers) do
    tower:draw()
  end

  for _, projectile in ipairs(projectiles) do
    projectile:draw()
  end

  for _, button in ipairs(buttons) do
    button:draw()
  end
end
