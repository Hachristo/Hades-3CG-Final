
require "vector"

ButtonClass = {}

BUTTON_STATE = {
  IDLE = 0,
  MOUSE_OVER = 1
}


function ButtonClass:new(text, xPos, yPos, textX, textY, width, height)
  local button = {}
  local metadata = {__index = ButtonClass}
  setmetatable(button, metadata)
  
  button.position = Vector(xPos, yPos)
  button.size = Vector(width, height)
  button.text = text
  button.textPos = Vector(xPos + textX, yPos + textY)
  button.state = BUTTON_STATE.IDLE
  
  return button
end

function ButtonClass:update()
  self:checkForMouseOver()
end

function ButtonClass:draw()
  if self.state == BUTTON_STATE.MOUSE_OVER then
    love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y)
    love.graphics.setColor(0, 0, 0, 1)
  else
    love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y)
  end
  love.graphics.print(self.text, self.textPos.x, self.textPos.y)
  love.graphics.setColor(1, 1, 1, 1)
end

function ButtonClass:checkForMouseOver()
  local mousePos = Vector(
    love.mouse.getX(),
    love.mouse.getY()
  )
  local isMouseOver = false
  isMouseOver = mousePos.x > self.position.x and
    mousePos.x < self.position.x + self.size.x and
    mousePos.y > self.position.y and
    mousePos.y < self.position.y + self.size.y

  if isMouseOver and love.mouse.isDown(1) then 
    love.event.push(self.text)
  elseif isMouseOver then
    self.state = BUTTON_STATE.MOUSE_OVER 
  else
    self.state = BUTTON_STATE.IDLE 
  end
end
