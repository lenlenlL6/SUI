# SUI
Love2d library helps to create a slideable UI, supports Android

# Hello World :D
Example:
```lua
local SUi = require("sui")

function love.load()
  w, h = love.graphics.getWidth(), love.graphics.getHeight()
  -- create a ui object
  -- (x, y, width, height, listener)
  -- x is the x-axis of ui
  -- y is the y-axis of ui
  -- width is the width of the ui
  -- height is the height of the ui
  -- listener is a function called when ui is touched without moving which can be used to handle buttons
  ui = SUi:new(w / 2 - 300 / 2, h / 2 - 300 / 2, 300, 300, function(x, y)
    print("Hi :3")
  end)
  boxCount = 7
  box = {}
  -- Create boxes to draw
  for i = 1, math.ceil(boxCount / 2) do
    local y = (135 * (i - 1)) + 10 * i
    local cL = 1
    if i * 2 <= boxCount then
      cL = 2
    end
    for s = 1, cL do
      local x = (135 * (s - 1)) + 10 * s
      table.insert(box, {x = x, y = y, w = 135, h = 135, fixedY = y})
    end
  end
end

function love.update(dt)
  -- update ui, will return a number, that is the distance from first touch
  local y = ui:update(dt)
  if y then
    for _, v in ipairs(box) do
      -- change the y-axis of the boxes
      v.y = v.fixedY - y
    end
  end
end

function love.draw()
  -- draw ui
  ui:draw(function()
    love.graphics.clear()
    -- draw boundaries, note when drawing, the position (0,0) is always the upper left corner of the ui
    love.graphics.rectangle("line", 0, 0, 300, 300)
    for _, v in ipairs(box) do
      love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
    end
  end)
end

function love.touchpressed(id, x, y)
  -- handle touch screen event
  ui:touchPressed(id, x, y, function()
    print("Yay")
  end)
end

function love.touchreleased(id, x, y)
  -- handle touch release event
  ui:touchReleased(id, x, y, function()
    for _, v in ipairs(box) do
      v.fixedY = v.y
    end
  end)
end
```


https://github.com/lenlenlL6/SUI/assets/62021442/5250ddbe-d967-4901-b270-e3c1bbb083b7

# Block swipe?
Sometimes you want to swipe to a certain position that won't be able to swipe anymore, here is the solution:
```lua
local SUi = require("sui")

function love.load()
  w, h = love.graphics.getWidth(), love.graphics.getHeight()
  -- create a ui object
  -- (x, y, width, height, listener)
  -- x is the x-axis of ui
  -- y is the y-axis of ui
  -- width is the width of the ui
  -- height is the height of the ui
  -- listener is a function called when ui is touched without moving which can be used to handle buttons
  ui = SUi:new(w / 2 - 300 / 2, h / 2 - 300 / 2, 300, 300, function(x, y)
    print("Hi :3")
  end)
  boxCount = 7
  box = {}
  -- Create boxes to draw
  for i = 1, math.ceil(boxCount / 2) do
    local y = (135 * (i - 1)) + 10 * i
    local cL = 1
    if i * 2 <= boxCount then
      cL = 2
    end
    for s = 1, cL do
      local x = (135 * (s - 1)) + 10 * s
      table.insert(box, {x = x, y = y, w = 135, h = 135, fixedY = y})
    end
  end
end

function love.update(dt)
  -- update ui, will return a number, that is the distance from first touch
  local y = ui:update(dt)
  if y then
    if box[1].fixedY - y > 10 then
      y = box[1].fixedY - 10
    end
    if (box[7].fixedY + 135) - y < 300 - 10 then
      y = ((box[7].fixedY + 135) - (300 - 10))
    end
    for _, v in ipairs(box) do
      -- change the y-axis of the boxes
      v.y = v.fixedY - y
    end
  end
end

function love.draw()
  -- draw ui
  ui:draw(function()
    love.graphics.clear()
    -- draw boundaries, note when drawing, the position (0,0) is always the upper left corner of the ui
    love.graphics.rectangle("line", 0, 0, 300, 300)
    for _, v in ipairs(box) do
      love.graphics.rectangle("line", v.x, v.y, v.w, v.h)
    end
  end)
end

function love.touchpressed(id, x, y)
  -- handle touch screen event
  ui:touchPressed(id, x, y, function()
    print("Yay")
  end)
end

function love.touchreleased(id, x, y)
  -- handle touch release event
  ui:touchReleased(id, x, y, function()
    for _, v in ipairs(box) do
      v.fixedY = v.y
    end
  end)
end
```
Just check the position and adjust the y-axis


https://github.com/lenlenlL6/SUI/assets/62021442/758fe935-2dd7-4396-aaad-afaf0a9b6ba5

