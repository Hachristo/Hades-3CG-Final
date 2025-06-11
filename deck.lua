
DeckClass = {}
Cards = {
  "Aphrodite",
  "Apollo",
  "Ares",
  "Artemis",
  "Demeter",
  "Dionysus",
  "Hades",
  "Hermes",
  "Minotaur",
  "Pegasus",
  "Poseidon",
  "Titan",
  "Wooden Cow",
  "Zeus",
  "Aphrodite",
  "Apollo",
  "Ares",
  "Artemis",
  "Demeter",
  "Dionysus",
  "Hades",
  "Hermes",
  "Minotaur",
  "Pegasus",
  "Poseidon",
  "Titan",
  "Wooden Cow",
  "Zeus",
  "Cyclops",
  "Hephaestus",
  "Hera",
  "Nyx",
  "Persephone",
  "Cyclops",
  "Hephaestus",
  "Hera",
  "Nyx",
  "Persephone"
}

function copyTable(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function DeckClass:new(discard, seed)
  local deck = {}
  local metadata = {__index = DeckClass}
  setmetatable(deck, metadata)
  
  deck.cards = {}
  deck.discard = discard
  deck.seed = seed
  
  deck.allCards = copyTable(Cards)
  
  math.randomseed(seed)
  
  return deck
end

function DeckClass:fillDeck()
  for i = 1, 20 do
--    local randomIndex = math.random(#self.allCards)
--    local card = self.allCards[randomIndex] .. ".png"
--    table.insert(self.cards, card)
--    table.remove(self.allCards, randomIndex)
    table.insert(self.cards, "Nyx.png")
  end
end

--function DeckClass:refillDeck()
--  for _, tableCard in ipairs(self.discard.cards) do
--    local card = "card_" .. tableCard.suit .. "_" .. tableCard.number .. ".png"
--    table.insert(deck.cards, card)
--  end
--  local length = #self.discard.cards
--  for i = 1, length do
--    table.remove(self.discard.cards, 1)
--  end
--end

--function DeckClass:popCard()
--  local cardIndex = math.random(#deck.cards)
--  local card = deck.cards[cardIndex]
--  table.remove(deck.cards, cardIndex)
--  return card
--end

function DeckClass:removeTopCard()
  local card = self.cards[1]
  table.remove(self.cards, 1)
  return card
end