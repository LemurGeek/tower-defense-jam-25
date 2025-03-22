local mt = {}
mt.__index = mt

function mt:add(item)
  self.items[#self.items + 1] = item
end

function mt:remove(item)
  for i, v in ipairs(self.items) do
    if v == item then
      table.remove(self.items, i)
      return true  -- Return true if an item was removed
    end
  end
  return false  -- Return false if the item was not found
end

function mt:findItemsByType(typeName)
  local results = {}
  for _, item in ipairs(self.items) do
    if item.type and item.type == typeName then
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
    return setmetatable({ items = {} }, mt)
  end
}
