local SUi = {}

function SUi:new(x, y, width, height, func)
  local sui = {}
  setmetatable(sui, {__index = self})
  sui.x = x
  sui.y = y
  sui.w = width
  sui.h = height
  sui.listener = func
  sui.canvas = love.graphics.newCanvas(width, height)
  return sui
end

function SUi:draw(func)
  self.canvas:renderTo(func)
  love.graphics.draw(self.canvas, self.x, self.y)
end

function SUi:update(dt)
  for _, v in ipairs(love.touch.getTouches()) do
    local x, y = self:toUiPosition(love.touch.getPosition(v))
    if x and self.sId == v then
      return self.stY - y
    end
  end
end

function SUi:touchPressed(id, x, y, func)
  if not self:toUiPosition(x, y) then
    return
  end
  if not self.sId then
    if func then
      func()
    end
    self.sId = id
    self.stX, self.stY = self:toUiPosition(x, y)
  end
end

function SUi:touchReleased(id, x, y, func)
  if self.sId == id then
    if func then
    func()
    end
    self.sId = nil
    self.endX, self.endY = self:toUiPosition(x, y)
    if self.endX == self.stX and self.endY == self.stY then
      self.listener(self.stX, self.stY)
    end
    self.stX, self.stY = nil, nil
  end
end

function SUi:toUiPosition(x, y)
  if x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.h then
    return x - self.x, y - self.y
  end
  return nil
end

return SUi
