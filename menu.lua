
require "vector"
require "button"

MenuClass = {}

function MenuClass:new()
  local menu = {}
  local metadata = {__index = MenuClass}
  setmetatable(menu, metadata)
  
  menu.buttons = {}
  table.insert(menu.buttons, ButtonClass:new("Play", 950, 250, 15, 5, 50, 20))
  table.insert(menu.buttons, ButtonClass:new("Credits", 950, 275, 7, 5, 50, 20))
  table.insert(menu.buttons, ButtonClass:new("Quit", 950, 300, 15, 5, 50, 20))
  
  return menu
end

function MenuClass:update()
  for _, button in ipairs(self.buttons) do
    button:update()
  end
end

function MenuClass:draw()
  love.graphics.draw(Backgrounds[3],0,0,0,1,1)
  love.graphics.setFont(titleFont)
  love.graphics.print("Hades: Battle for the Underworld", 490, 100, 0, 1, 1)
  love.graphics.setFont(defaultFont)
  for _, button in ipairs(self.buttons) do
    button:draw()
  end
end

function love.handlers.Credits()
  scene = 3
end

function love.handlers.Play()
  loadGame(seed, seedAI)
  scene = 2
end

function love.handlers.Quit()
  love.event.quit()
end