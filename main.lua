package.path = package.path .. ";./?.lua;objects/?.lua;levels/?.lua;states/?.lua"

-- gridSize = 40 -- Each tile is 40x40 pixels
-- gridWidth = 20 -- Number of columns
-- gridHeight = 20 -- Number of rows

-- grid = {}

-- Base = require("base")
-- Tower = require("tower")
-- Projectile = require("Projectile")
-- Enemy = require("enemy")
-- Button = require("button")
-- path = require("path")

-- function love.load()
--   enemies = {}
--   towers = {}
--   projectiles = {}
--   spawnTimer = 2
--   base = Base:new(path[#path].x, path[#path].y) -- Base at the end of the path (TODO: Improve this logic later)
--   buttons = {
--     -- ID, x, y , width, height, color, hoverColor, clickColor, text, buttonClick
--     Button:new(0, 250, 550, 100, 50, {0.2, 0.5, 0.8}, {0.3, 0.7, 1}, {0.1, 0.3, 0.6}, "Tower", false), 
--     Button:new(1, 350, 550, 100, 50, {0.2, 0.5, 0.8}, {0.3, 0.7, 1}, {0.1, 0.3, 0.6}, "Tower", false)
--   }
--   font = love.graphics.newFont(20)  -- Font

--   towerSelected = false
--   selectedTowerType = 0  -- Add a tower type selector for normal or slow tower

--   -- Grid System
--   for y = 1, gridHeight do
--     grid[y] = {}
--     for x = 1, gridWidth do
--       grid[y][x] = nil -- Empty by default
--     end
--   end
-- end

-- function love.update(dt)
--   spawnTimer = spawnTimer - dt
--   if spawnTimer <= 0 then
--     table.insert(enemies, Enemy:new(base))
--     spawnTimer = 2
--   end

--   -- Update enemies
--   for i = #enemies, 1, -1 do
--     if not enemies[i]:update(dt) then
--       table.remove(enemies, i)
--     end
--   end

--   -- Update towers
--   for _, tower in ipairs(towers) do
--     tower:update(dt, enemies, projectiles) 
--   end

--   -- Update projectiles
--   for i = #projectiles, 1, -1 do
--     if not projectiles[i]:update(dt) then
--       table.remove(projectiles, i)
--     end
--   end

--   -- Update buttons
--   for _, button in ipairs(buttons) do
--     button:update(
--       function() 
--         towerSelected = not towerSelected
--         selectedTowerType = button.id
--         print(selectedTowerType) 
--       end
--     )
--   end
-- end

-- function love.mousepressed(x, y, button)
--   if button == 1 and towerSelected then -- Left mouse click
--     local gridX = math.floor(x / gridSize) + 1
--     local gridY = math.floor(y / gridSize) + 1

--     -- Check if it's within the grid and empty
--     if (gridX > 0 and gridX <= gridWidth) and (gridY > 0 and gridY <= gridHeight) and not grid[gridY][gridX] then
--       local snappedX = (gridX * gridSize) - (gridSize / 2)
--       local snappedY = (gridY * gridSize) - (gridSize / 2)

--       -- Randomly choose between normal tower (1) or slow tower (2)
--       local towerType = math.random(1, 2)

--       if selectedTowerType == 0 then
--         newTower = Tower:new(snappedX, snappedY)  -- Create a normal tower
--       elseif selectedTowerType == 1 then
--         newTower = Tower:createSlowTower(snappedX, snappedY)  -- Create a slow tower
--       end

--       table.insert(towers, newTower)
--       grid[gridY][gridX] = newTower -- Mark tile as occupied

--       towerSelected = not towerSelected
--     end

--   end
-- end

-- function love.draw()
--   love.graphics.setBackgroundColor(love.math.colorFromBytes(43, 40, 33))

--   base:draw()

--   -- Draw grid
--   love.graphics.setColor(0.8, 0.8, 0.8) -- Light gray grid
--   for y = 0, gridHeight - 1 do
--     for x = 0, gridWidth - 1 do
--       love.graphics.rectangle("line", x * gridSize, y * gridSize, gridSize, gridSize)
--     end
--   end

--   for _, enemy in ipairs(enemies) do
--     enemy:draw()
--   end

--   for _, tower in ipairs(towers) do
--     tower:draw()
--   end

--   for _, projectile in ipairs(projectiles) do
--     projectile:draw()
--   end

--   for _, button in ipairs(buttons) do
--     button:draw()
--   end
-- end

local GameState = require('GameState')

function love.load()
  GameState.setCurrent('Play')
end

function love.update(dt)
  GameState.getCurrent():update(dt)
  GameState.update()
end

function love.draw()
  -- love.graphics.scale(2, 2)
  GameState.getCurrent():draw()
end

