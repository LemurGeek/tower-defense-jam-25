package.path = package.path .. ";./?.lua;objects/?.lua;levels/?.lua;states/?.lua"

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

function love.mousepressed(x, y, button)
  GameState.getCurrent():mousepressed(x, y, button)
end
