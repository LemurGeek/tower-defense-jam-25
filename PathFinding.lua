local function distance(p1, p2)
  local dx, dy = p1.x - p2.x, p1.y - p2.y
  return math.sqrt(dx * dx + dy * dy)
end

-- Function to sort path points by proximity
function sortPathPoints(pathPoints)
  local sorted = {}
  local visited = {}
  local current = table.remove(pathPoints, 1) -- Start with the first point
  sorted[#sorted + 1] = current
  visited[current] = true

  while #pathPoints > 0 do
    -- Find the nearest point to the current point
    local nearestIndex, nearestDistance = nil, math.huge
    for i, point in ipairs(pathPoints) do
      if not visited[point] then
        local dist = distance(current, point)
        if dist < nearestDistance then
          nearestIndex, nearestDistance = i, dist
        end
      end
    end

    -- Add the nearest point to the sorted list and remove it from the original list
    current = table.remove(pathPoints, nearestIndex)
    sorted[#sorted + 1] = current
    visited[current] = true
  end

  return sorted
end

return {
  sortPathPoints = sortPathPoints
}