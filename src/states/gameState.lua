-- Models
local PlayerModel = require("models/playerModel")

-- Systems
local DrawSystem = require("systems/draw/drawSystem")
local PlayerControlSystem = require("systems/pressedevent/playerControlSystem")

-- Events
local KeyPressed = require("events/keyPressed")

-- State superclass
local State = require("core/state")
local GameState = class("GameState", State)

function GameState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()

    self.engine:addSystem(PlayerControlSystem(), "logic", 1)

    self.engine:addSystem(DrawSystem(), "draw", 1)

    self.player = PlayerModel()
    self.engine:addEntity(self.player)
end

function GameState:update(dt)
    self.engine:update(dt)
end

function GameState:draw()
    self.engine:draw()
end

function GameState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

return GameState
