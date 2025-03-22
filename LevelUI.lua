local PADDING = 5

local Button = require('ui.Button')
local Box = require('ui.Box')

local mt = {}
mt.__index = mt

function mt:towerBtnClick(selectedTower)
  self.towerSelected = not self.towerSelected
  self.selectedTower = selectedTower
end

return {
  new = function(game_state)
    local lvlUI = setmetatable({ 
      towerSelected = false,
      selectedTower = 'normal' 
    }, mt)
    
    game_state.UI:add(Box.new(game_state.UI.startX + PADDING, 0, 200 - PADDING, 800, {93, 114, 117}))

    game_state.UI:add(Button.new(
      (game_state.UI.startX + PADDING) + 50, 80, 100, 50,
      {92, 139, 147}, {102, 159, 167}, {112, 179, 187},
      "Classic Tower",
      false,
      function() lvlUI:towerBtnClick("normal") end -- Closure to pass parameter
    ))

    game_state.UI:add(Button.new(
      (game_state.UI.startX + PADDING) + 50, 160, 100, 50,
      {92, 139, 147}, {102, 159, 167}, {112, 179, 187},
      "Slow Tower",
      false,
      function() lvlUI:towerBtnClick("slow") end -- Closure to pass parameter
    ))

    return lvlUI
  end
}
