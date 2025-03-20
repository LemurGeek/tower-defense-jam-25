local Button = require('ui.Button')
local Box = require('ui.Box')

local mt = {}
mt.__index = mt

function mt:add(item)
  self.items[#self.items + 1] = item
end

function mt:findItemsByType(typeName)
  local results = {}
  for _, item in ipairs(self.items) do
    if item.typeUI and item.typeUI == typeName then
      results[#results + 1] = item
    end
  end
  if(#results == 1) then
    return results[1] -- Return the first matching item
  end
  return results -- Return a table of all matching items
end



return {
  new = function()
    local UI = setmetatable({ items = {}, startX = 800 }, mt)

    local PADDING = 5

    UI:add(Box.new(UI.startX + PADDING, 0, 200 - PADDING, 800, {93, 114, 117}))
    UI:add(Button.new((UI.startX + PADDING) + 50, 80, 100, 50, {92, 139, 147}, {102, 159, 167}, {112, 179, 187}, "Classic Tower", false, {})) -- TODO: add Action to click

    return UI
  end
}
