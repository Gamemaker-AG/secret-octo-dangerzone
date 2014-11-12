-- Models
local PlayerModel = require("models/playerModel")

-- Graphic systems
local DrawSystem = require("systems/draw/drawSystem")
local StringDrawSystem = require("systems/draw/stringDrawSystem")


-- Physic systems
local MovementSystem = require("systems/physic/movementSystem")
local AccelerationSystem = require("systems/physic/accelerationSystem")
local RotationSystem = require("systems/physic/rotationSystem")

-- PlayerSystems
local PlayerControlSystem = require("systems/gameplay/playerControlSystem")

-- Events
local KeyPressed = require("events/keyPressed")
local KeyReleased = require("events/keyReleased")

-- Components
local DrawableText = require("components/graphic/drawableText")
local Transformable = require("components/physic/transformable")

-- Helper
local Vector = require("helper/vector")

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

    self.engine:addSystem(DrawSystem(), "draw", 1)
    self.engine:addSystem(StringDrawSystem(), "draw", 2)

    self.eventmanager:addListener("KeyPressed", {playercontrol, playercontrol.fireEvent})
    self.eventmanager:addListener("KeyReleased", {playercontrol, playercontrol.fireEvent})

    self.player = PlayerModel()
    self.engine:addEntity(self.player)
    local posstring = Entity()
    posstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Position %i %i", {{self.player:get("Transformable").position, "x"},{self.player:get("Transformable").position, "y"}} ))
    posstring:add(Transformable(Vector(50,50)))
    self.engine:addEntity(posstring)
    local speedstring = Entity()
    speedstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Speed %i %i", {{self.player:get("Moving").speed, "x"}, {self.player:get("Moving").speed, "y"}} ))
    speedstring:add(Transformable(Vector(50,100)))
    self.engine:addEntity(speedstring)
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
