-- This module is responsible for handing current game state. 
local GameState = {}

function GameState.setCurrent(state_name)
  GameState.next_current = require('states.' .. state_name .. 'State').new()
  if not GameState.current then
    GameState.update()
  end
end

function GameState.getCurrent()
  return GameState.current
end

-- We don't actualy set the current scene in setCurrent so every scene has chance to finish it's frame before
-- it's closed.
function GameState.update()
  GameState.current = GameState.next_current
end

return GameState
