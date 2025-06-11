require "vector"
require "button"

CreditsClass = {}

function CreditsClass:new()
  local credits = {}
  local metadata = {__index = CreditsClass}
  setmetatable(credits, metadata)
  
  credits.buttons = {}
  table.insert(credits.buttons, ButtonClass:new("Back", 200, 50, 15, 5, 50, 20))
  
  return credits
end

function CreditsClass:update()
  for _, button in ipairs(self.buttons) do
    button:update()
  end
end

function CreditsClass:draw()
  love.graphics.draw(Backgrounds[2],0,0,0,1,1)
  love.graphics.setFont(titleFont)
  love.graphics.print("Credits", 200, 100, 0, 1, 1)
  love.graphics.setFont(defaultFont)
  
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle("fill", 200, 200, 200, 400)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("line", 200, 200, 200, 400)
  
  love.graphics.print("Developer", 205, 205, 0, 1, 1)
  love.graphics.print("Henry Christopher", 225, 230, 0, 1, 1)
  
  love.graphics.print("Backgrounds/Card Art", 205, 260, 0, 1, 1)
  love.graphics.print("Hades", 225, 285, 0, 1, 1)
  
  love.graphics.print("Card Back", 205, 315, 0, 1, 1)
  love.graphics.print("Kenney Assets", 225, 340, 0, 1, 1)
  for _, button in ipairs(self.buttons) do
    button:draw()
  end
end

function love.handlers.Back()
  scene = 1
end