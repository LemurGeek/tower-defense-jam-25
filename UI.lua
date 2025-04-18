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
    local UI = setmetatable({ 
      items = {}, 
      startX = 800
    }, mt)

    return UI
  end
}
