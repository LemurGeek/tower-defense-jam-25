local mt = {}
mt.__index = mt

function mt:add(item)
  self.items[#self.items + 1] = item
end

function mt:move(item, new_x, new_y, param)
  -- TODO
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

return {
  new = function()
    return setmetatable({ items = {} }, mt)
  end
}
