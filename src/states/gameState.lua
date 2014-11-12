-- Models
local PlayerModel = require("models/playerModel")

-- Graphic systems
local DrawSystem = require("systems/draw/drawSystem")

-- Physic systems
local MovementSystem = require("systems/physic/movementSystem")
local AccelerationSystem = require("systems/physic/accelerationSystem")
local RotationSystem = require("systems/physic/rotationSystem")

-- Gameplay 
local PlayerControlSystem = require("systems/gameplay/playerControlSystem")
local WeaponSystem = require("systems/gameplay/weaponSystem")

-- Events
local KeyPressed = require("events/keyPressed")
local KeyReleased = require("events/keyReleased")

-- State superclass
local State = require("core/state")
local GameState = class("GameState", State)

function GameState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
    
    local playercontrol = PlayerControlSystem()
    self.engine:addSystem(playercontrol, "logic", 1)
    self.engine:addSystem(AccelerationSystem(), "logic", 2)
    self.engine:addSystem(MovementSystem(), "logic", 3)
    self.engine:addSystem(RotationSystem(), "logic", 4)
    self.engine:addSystem(WeaponSystem(), "logic", 5)

    self.engine:addSystem(DrawSystem(), "draw", 1)

    self.eventmanager:addListener("KeyPressed", {playercontrol, playercontrol.fireEvent})
    self.eventmanager:addListener("KeyReleased", {playercontrol, playercontrol.fireEvent})

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

function GameState:keyreleased(key, isrepeat)
    self.eventmanager:fireEvent(KeyReleased(key, isrepeat))
end


return GameState
