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

function love.load()
  enemies = {}
  towers = {}
  projectiles = {}
  spawnTimer = 2
  base = Base:new(path[#path].x, path[#path].y) -- Base at the end of the path (TODO: Improve this logic later)
  buttons = {Button:new()}
  font = love.graphics.newFont(20)  -- Font

  towerSelected = false
  selectedTowerType = "normal"  -- Add a tower type selector for normal or slow tower

  -- Grid System
  for y = 1, gridHeight do
    grid[y] = {}
    for x = 1, gridWidth do
      grid[y][x] = nil -- Empty by default
    end
  end
end

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
    tower:update(dt, enemies, projectiles) 
  end

  -- Update projectiles
  for i = #projectiles, 1, -1 do
    if not projectiles[i]:update(dt) then
      table.remove(projectiles, i)
    end
  end

  -- Update buttons
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

      -- Randomly choose between normal tower (1) or slow tower (2)
      local towerType = math.random(1, 2)

      local newTower
      if towerType == 1 then
        newTower = Tower:new(snappedX, snappedY)  -- Create a normal tower
      else
        newTower = Tower:createSlowTower(snappedX, snappedY)  -- Create a slow tower
      end

      table.insert(towers, newTower)
      grid[gridY][gridX] = newTower -- Mark tile as occupied
    end

    towerSelected = not towerSelected
  end
end

function love.draw()
  love.graphics.setBackgroundColor(love.math.colorFromBytes(43, 40, 33))

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
