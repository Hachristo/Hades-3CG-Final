
require "vector"

CardClass = {}

CARD_STATE = {
  IDLE = 0,
  MOUSE_OVER = 1,
  GRABBED = 2
}

ENTITIES = {
  PLAYER = 1,
  AI = 2
}

SPRITE_SIZE = 8
SPRITE_SCALE = 0.6

Cost = {
  ["Aphrodite.png"] = 4,
  ["Apollo.png"] = 3,
  ["Ares.png"] = 5,
  ["Artemis.png"] = 3,
  ["Demeter.png"] = 3,
  ["Dionysus.png"] = 3,
  ["Hades.png"] = 6,
  ["Hermes.png"] = 2,
  ["Minotaur.png"] = 5,
  ["Pegasus.png"] = 3,
  ["Poseidon.png"] = 5,
  ["Titan.png"] = 6,
  ["Wooden Cow.png"] = 1,
  ["Zeus.png"] = 5,
  ["Cyclops.png"] = 2,
  ["Hera.png"] = 3,
  ["Hephaestus.png"] = 2,
  ["Persephone.png"] = 2,
  ["Nyx.png"] = 4
}

Power = {
  ["Aphrodite.png"] = 3,
  ["Apollo.png"] = 5,
  ["Ares.png"] = 10,
  ["Artemis.png"] = 7,
  ["Demeter.png"] = 8,
  ["Dionysus.png"] = 4,
  ["Hades.png"] = 8,
  ["Hermes.png"] = 5,
  ["Minotaur.png"] = 9,
  ["Pegasus.png"] = 5,
  ["Poseidon.png"] = 9,
  ["Titan.png"] = 12,
  ["Wooden Cow.png"] = 1,
  ["Zeus.png"] = 9,
  ["Cyclops.png"] = 4,
  ["Hera.png"] = 4,
  ["Hephaestus.png"] = 3,
  ["Persephone.png"] = 4,
  ["Nyx.png"] = 5
}

function CardClass:new(xPos, yPos, sprite, draggable, faceUp, player)
  local card = {}
  local metadata = {__index = CardClass}
  setmetatable(card, metadata)
  
  card.position = Vector(xPos, yPos)
  card.size = Vector(142, 200)
  card.scale = SPRITE_SCALE
  card.state = CARD_STATE.IDLE
  card.side = faceUp
  card.bottomCard = faceUp
  
  card.name = sprite
  card.cost = Cost[sprite]
  card.power = Power[sprite]
  card.player = player
  
  card.revealed = false
  
  card.image = love.graphics.newImage("NewSprites/" .. sprite)
  card.back = love.graphics.newImage("Sprites/card_back.png")
  
  card.draggable = draggable
  
  return card
end

function CardClass:update()
  
end

function CardClass:draw()
  if self.side then
    if self.state == CARD_STATE.GRABBED then
      love.graphics.draw(self.image, self.position.x, self.position.y, 0, self.scale + 0.05, self.scale + 0.05)
      love.graphics.rectangle("line", self.position.x - 1, self.position.y - 1, self.size.x + 15, self.size.y + 18, 6, 6)
      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.print(self.cost, self.position.x + 19, self.position.y + 195)
      if self.power > 9 then
        love.graphics.print(self.power, self.position.x + 123, self.position.y + 195)
      else
        love.graphics.print(self.power, self.position.x + 128, self.position.y + 195)
      end
      love.graphics.setColor(1, 1, 1, 1)
    else
      love.graphics.draw(self.image, self.position.x, self.position.y, 0, self.scale, self.scale)
      if self.state == CARD_STATE.MOUSE_OVER then
        love.graphics.rectangle("line", self.position.x - 1, self.position.y - 1, self.size.x + 2, self.size.y + 2, 6, 6)
      end
      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.print(self.cost, self.position.x + 16, self.position.y + 179)
      if self.power > 9 then
        love.graphics.print(self.power, self.position.x + 115, self.position.y + 179)
      else
        love.graphics.print(self.power, self.position.x + 120, self.position.y + 179)
      end
      love.graphics.setColor(1, 1, 1, 1)
    end

  else
    love.graphics.draw(self.back, self.position.x, self.position.y, 0, 3.45, 3.45)
  end
  
end

function CardClass:checkForMouseOver(grabber)
  if self.state == CARD_STATE.GRABBED or not self.draggable then
    return
  end
    
  local mousePos = grabber.currentMousePos
  local isMouseOver = false
  isMouseOver = mousePos.x > self.position.x and
    mousePos.x < self.position.x + self.size.x and
    mousePos.y > self.position.y and
    mousePos.y < self.position.y + self.size.y
  
  self.state = isMouseOver and CARD_STATE.MOUSE_OVER or CARD_STATE.IDLE
end

function CardClass:onReveal()
  stringFunction[self.name]()
end
-- Card Subclasses
-- Wooden Cow
WoodenCowPrototype = CardClass:new(0, 0, "Wooden Cow.png", false, false, 0)
function WoodenCowPrototype:new(_player)
  local card = CardClass:new(0, 0, "Wooden Cow.png", false, false, _player)
  local metadata = {__index = WoodenCowPrototype}
  setmetatable(card, metadata)
  return card
end
function WoodenCowPrototype:onReveal(cardLocation)
  self.revealed = true
end
-- Pegasus
PegasusPrototype = CardClass:new(0, 0, "Pegasus.png", false, false, 0)
function PegasusPrototype:new(_player)
  local card = CardClass:new(0, 0, "Minotaur.png", false, false, _player)
  local metadata = {__index = PegasusPrototype}
  setmetatable(card, metadata)
  return card
end
function PegasusPrototype:onReveal(cardLocation)
  self.revealed = true
end
-- Minotaur
MinotaurPrototype = CardClass:new(0, 0, "Minotaur.png", false, false, 0)
function MinotaurPrototype:new(_player)
  local card = CardClass:new(0, 0, "Minotaur.png", false, false, _player)
  local metadata = {__index = MinotaurPrototype}
  setmetatable(card, metadata)
  return card
end
function MinotaurPrototype:onReveal(cardLocation)
  self.revealed = true
end
-- Titan
TitanPrototype = CardClass:new(0, 0, "Titan.png", false, false, 0)
function TitanPrototype:new(_player)
  local card = CardClass:new(0, 0, "Titan.png", false, false, _player)
  local metadata = {__index = TitanPrototype}
  setmetatable(card, metadata)
  return card
end
function TitanPrototype:onReveal(cardLocation)
  self.revealed = true
end
-- Zeus
ZeusPrototype = CardClass:new(0, 0, "Zeus.png", false, false, 0)
function ZeusPrototype:newCard(_player)
  local card = CardClass:new(0, 0, "Zeus.png", false, false, _player)
  local metadata = {__index = ZeusPrototype}
  setmetatable(card, metadata)
  return card
end
function ZeusPrototype:onReveal(cardLocation)
  local enemyHand = pileTable[10]
  if self.player == 2 then
    enemyHand = pileTable[5]
  end
  for _, card in ipairs(enemyHand.cards) do
    card.power = card.power - 1
  end
  self.revealed = true
end
-- Ares
AresPrototype = CardClass:new(0, 0, "Ares.png", false, false, 0)
function AresPrototype:new(_player)
  local card = CardClass:new(0, 0, "Ares.png", false, false, _player)
  local metadata = {__index = AresPrototype}
  setmetatable(card, metadata)
  return card
end
function AresPrototype:onReveal(cardLocation)
  local enemyLocation = pileTable[6]
  if cardLocation == 1 then
    if self.player == 2 then
      enemyLocation = pileTable[1]
    end
  elseif cardLocation == 2 then
    enemyLocation = pileTable[7]
    if self.player == 2 then
      enemyLocation = pileTable[2]
    end
  else
    enemyLocation = pileTable[8]
    if self.player == 2 then
      enemyLocation = pileTable[3]
    end
  end
  self.power = self.power + #enemyLocation.cards * 2
  self.revealed = true
end
-- Poseidon
PoseidonPrototype = CardClass:new(0, 0, "Poseidon.png", false, false, 0)
function PoseidonPrototype:new(_player)
  local card = CardClass:new(0, 0, "Poseidon.png", false, false, _player)
  local metadata = {__index = PoseidonPrototype}
  setmetatable(card, metadata)
  return card
end
function PoseidonPrototype:onReveal(cardLocation)
  local enemyLocation = pileTable[6]
  local newLocation = pileTable[7]
  if cardLocation == 1 then
    if self.player == 2 then
      enemyLocation = pileTable[1]
      newLocation = pileTable[2]
    end
  elseif cardLocation == 2 then
    enemyLocation = pileTable[7]
    newLocation = pileTable[8]
    if self.player == 2 then
      enemyLocation = pileTable[2]
      newLocation = pileTable[3]
    end
  else
    enemyLocation = pileTable[8]
    newLocation = pileTable[6]
    if self.player == 2 then
      enemyLocation = pileTable[3]
      newLocation = pileTable[1]
    end
  end
  local lowestCard = nil
  local lowestPower = 0
  for _, card in ipairs(enemyLocation.cards) do
    if card.power > lowestPower then
      lowestCard = card
      lowestPower = card.power
    end
  end
  enemyLocation:removeCard(lowestCard)
  newLocation:addCard(lowestCard)
  self.revealed = true
end
-- Artemis
ArtemisPrototype = CardClass:new(0, 0, "Artemis.png", false, false, 0)
function ArtemisPrototype:new(_player)
  local card = CardClass:new(0, 0, "Artemis.png", false, false, _player)
  local metadata = {__index = ArtemisPrototype}
  setmetatable(card, metadata)
  return card
end
function ArtemisPrototype:onReveal(cardLocation)
  local enemyLocation = pileTable[6]
  if cardLocation == 1 then
    if self.player == 2 then
      enemyLocation = pileTable[1]
    end
  elseif cardLocation == 2 then
    enemyLocation = pileTable[7]
    if self.player == 2 then
      enemyLocation = pileTable[2]
    end
  else
    enemyLocation = pileTable[8]
    if self.player == 2 then
      enemyLocation = pileTable[3]
    end
  end
  if #enemyLocation.cards == 1 then
    self.power = self.power + 5
  end
  self.revealed = true
end
-- Demeter
DemeterPrototype = CardClass:new(0, 0, "Demeter.png", false, false, 0)
function DemeterPrototype:new(_player)
  local card = CardClass:new(0, 0, "Demeter.png", false, false, _player)
  local metadata = {__index = DemeterPrototype}
  setmetatable(card, metadata)
  return card
end
function DemeterPrototype:onReveal(cardLocation)
  drawPilePlayer:drawCards()
  drawPileAI:drawCards()
  self.revealed = true
end
-- Hades
HadesPrototype = CardClass:new(0, 0, "Hades.png", false, false, 0)
function HadesPrototype:new(_player)
  local card = CardClass:new(0, 0, "Hades.png", false, false, _player)
  local metadata = {__index = HadesPrototype}
  setmetatable(card, metadata)
  return card
end
function HadesPrototype:onReveal(cardLocation)
  if self.player == 1 then
    self.power = self.power + (#pileTable[4].cards * 2)
  else
    self.power = self.power + (#pileTable[9].cards * 2)
  end
  self.revealed = true
end
-- Dionysus
DionysusPrototype = CardClass:new(0, 0, "Dionysus.png", false, false, 0)
function DionysusPrototype:new(_player)
  local card = CardClass:new(0, 0, "Dionysus.png", false, false, _player)
  local metadata = {__index = DionysusPrototype}
  setmetatable(card, metadata)
  return card
end
function DionysusPrototype:onReveal(cardLocation)
  local playerLocation = pileTable[1]
  if cardLocation == 1 then
    if self.player == 2 then
      playerLocation = pileTable[6]
    end
  elseif cardLocation == 2 then
    playerLocation = pileTable[2]
    if self.player == 2 then
      playerLocation = pileTable[7]
    end
  else
    playerLocation = pileTable[3]
    if self.player == 2 then
      playerLocation = pileTable[8]
    end
  end
  self.power = self.power + (#playerLocation.cards - 1) * 2
  self.revealed = true
end
-- Hermes
HermesPrototype = CardClass:new(0, 0, "Hermes.png", false, false, 0)
function HermesPrototype:new(_player)
  local card = CardClass:new(0, 0, "Hermes.png", false, false, _player)
  local metadata = {__index = HermesPrototype}
  setmetatable(card, metadata)
  return card
end
function HermesPrototype:onReveal(cardLocation)
  local startLocation = pileTable[1]
  local newLocation = pileTable[2]
  if cardLocation == 1 then
    if self.player == 2 then
      startLocation = pileTable[6]
      newLocation = pileTable[7]
    end
  elseif cardLocation == 2 then
    startLocation = pileTable[2]
    newLocation = pileTable[3]
    if self.player == 2 then
      startLocation = pileTable[7]
      newLocation = pileTable[8]
    end
  else
    startLocation = pileTable[3]
    newLocation = pileTable[1]
    if self.player == 2 then
      startLocation = pileTable[8]
      newLocation = pileTable[6]
    end
  end
  startLocation:removeCard(self)
  newLocation:addCard(self)
  self.revealed = true
end
-- Aphrodite
AphroditePrototype = CardClass:new(0, 0, "Aphrodite.png", false, false, 0)
function AphroditePrototype:new(_player)
  local card = CardClass:new(0, 0, "Aphrodite.png", false, false, _player)
  local metadata = {__index = AphroditePrototype}
  setmetatable(card, metadata)
  return card
end
function AphroditePrototype:onReveal(cardLocation)
  local enemyLocation = pileTable[6]
  if cardLocation == 1 then
    if self.player == 2 then
      enemyLocation = pileTable[1]
    end
  elseif cardLocation == 2 then
    enemyLocation = pileTable[7]
    if self.player == 2 then
      enemyLocation = pileTable[2]
    end
  else
    enemyLocation = pileTable[8]
    if self.player == 2 then
      enemyLocation = pileTable[3]
    end
  end
  for _, card in ipairs(enemyLocation.cards) do
    card.power = card.power - 1
  end
  self.revealed = true
end
-- Apollo
ApolloPrototype = CardClass:new(0, 0, "Apollo.png", false, false, 0)
function ApolloPrototype:new(_player)
  local card = CardClass:new(0, 0, "Apollo.png", false, false, _player)
  local metadata = {__index = ApolloPrototype}
  setmetatable(card, metadata)
  return card
end
function ApolloPrototype:onReveal(cardLocation)
  if self.player == 1 then
    playerBonusMana = playerBonusMana + 1
  else
    AIBonusMana = AIBonusMana + 1
  end
  self.revealed = true
end
-- Cyclops
CyclopsPrototype = CardClass:new(0, 0, "Cyclops.png", false, false, 0)
function CyclopsPrototype:new(_player)
  local card = CardClass:new(0, 0, "Cyclops.png", false, false, _player)
  local metadata = {__index = CyclopsPrototype}
  setmetatable(card, metadata)
  return card
end
function CyclopsPrototype:onReveal(cardLocation)
  if self.player == 1 then
    for _, card in ipairs(pileTable[cardLocation].cards) do
      if card == self then
        
      else
        pileTable[cardLocation]:removeCard(card)
        pileTable[4]:addCard(card)
        self.power = self.power + 2
      end
    end
  else
    for _, card in ipairs(pileTable[5 + cardLocation].cards) do
      if card == self then
        
      else
        pileTable[5 + cardLocation]:removeCard(card)
        pileTable[9]:addCard(card)
        self.power = self.power + 2
      end
    end
  end
  self.revealed = true
end
-- Hephaestus
HephaestusPrototype = CardClass:new(0, 0, "Hephaestus.png", false, false, 0)
function HephaestusPrototype:new(_player)
  local card = CardClass:new(0, 0, "Hephaestus.png", false, false, _player)
  local metadata = {__index = HephaestusPrototype}
  setmetatable(card, metadata)
  return card
end
function HephaestusPrototype:onReveal(cardLocation)
  if self.player == 1 then
    for i = 1, 2 do
      if pileTable[5].cards[i] ~= nil then
        pileTable[5].cards[i].cost = pileTable[5].cards[i].cost - 1
      end
    end
  else
    for i = 1, 2 do
      if pileTable[10].cards[i] ~= nil then
        pileTable[10].cards[i].cost = pileTable[10].cards[i].cost - 1
      end
    end
  end
  self.revealed = true
end
-- Hera
HeraPrototype = CardClass:new(0, 0, "Hera.png", false, false, 0)
function HeraPrototype:new(_player)
  local card = CardClass:new(0, 0, "Hera.png", false, false, _player)
  local metadata = {__index = HeraPrototype}
  setmetatable(card, metadata)
  return card
end
function HeraPrototype:onReveal(cardLocation)
  if self.player == 1 then
    for _, card in ipairs(pileTable[5].cards) do
      card.power = card.power + 1
    end
  else
    for _, card in ipairs(pileTable[10].cards) do
      card.power = card.power + 1
    end
  end
  self.revealed = true
end
-- Nyx
NyxPrototype = CardClass:new(0, 0, "Nyx.png", false, false, 0)
function NyxPrototype:new(_player)
  local card = CardClass:new(0, 0, "Nyx.png", false, false, _player)
  local metadata = {__index = NyxPrototype}
  setmetatable(card, metadata)
  return card
end
function NyxPrototype:onReveal(cardLocation)
  if self.player == 1 then
    for _, card in ipairs(pileTable[cardLocation].cards) do
      if card ~= self then
        pileTable[cardLocation]:removeCard(card)
        pileTable[4]:addCard(card)
        self.power = self.power + card.power
      end
    end
  else
    for _, card in ipairs(pileTable[5 + cardLocation].cards) do
      if card ~= self then
        pileTable[5 + cardLocation]:removeCard(card)
        pileTable[9]:addCard(card)
        self.power = self.power + card.power
      end
    end
  end
  self.revealed = true
end
-- Persephone
PersephonePrototype = CardClass:new(0, 0, "Persephone.png", false, false, 0)
function PersephonePrototype:new(_player)
  local card = CardClass:new(0, 0, "Persephone.png", false, false, _player)
  local metadata = {__index = PersephonePrototype}
  setmetatable(card, metadata)
  return card
end
function PersephonePrototype:onReveal(cardLocation)
  if self.player == 1 then
    local lowestCard = nil
    local lowestPower = 20
    for _, card in ipairs(pileTable[5].cards) do
      if card.power < lowestPower then
        lowestCard = card
        lowestPower = card.power
      end
    end
    if lowestCard == nil then
      self.revealed = true
      return
    end
    pileTable[5]:removeCard(lowestCard)
    pileTable[4]:addCard(lowestCard)
  else
    local lowestCard = nil
    local lowestPower = 20
    for _, card in ipairs(pileTable[10].cards) do
      if card.power < lowestPower then
        lowestCard = card
        lowestPower = card.power
      end
    end
    if lowestCard == nil then
      self.revealed = true
      return
    end
    pileTable[10]:removeCard(lowestCard)
    pileTable[9]:addCard(lowestCard)
  end
  self.revealed = true
end
