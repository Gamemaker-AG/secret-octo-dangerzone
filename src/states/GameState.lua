-- Models
local PlayerModel = require("models/PlayerModel")
local EnemyModel = require("models/EnemyModel")

-- Graphic systems
local DrawSystem = require("systems/draw/DrawSystem")
local StringDrawSystem = require("systems/draw/StringDrawSystem")
local CameraSystem = require("systems/draw/CameraSystem")

-- Particle systems 
local ParticleDrawSystem = require("systems/particle/ParticleDrawSystem")
local ParticlePositionSyncSystem = require("systems/particle/ParticlePositionSyncSystem")
local ParticleUpdateSystem = require("systems/particle/ParticleUpdateSystem")

-- Physic systems
local MovementSystem = require("systems/physic/MovementSystem")
local AccelerationSystem = require("systems/physic/AccelerationSystem")
local RotationSystem = require("systems/physic/RotationSystem")

-- Gameplay 
local WeaponSystem = require("systems/gameplay/WeaponSystem")
local FacingSystem = require("systems/gameplay/FacingSystem")
local TargetingSystem = require("systems/gameplay/TargetingSystem")
local TargetMoveSystem = require("systems/gameplay/TargetMoveSystem")
local PlayerControlSystem = require("systems/gameplay/PlayerControlSystem")
local ExplodeOnContactSystem = require("systems/gameplay/ExplodeOnContactSystem")

-- Events
local KeyPressed = require("events/KeyPressed")
local KeyReleased = require("events/KeyReleased")

-- Components
local DrawableText = require("components/graphic/DrawableText")
local Transformable = require("components/physic/Transformable")

-- Helper
local Vector = require("helper/Vector")

-- State superclass
local State = require("core/State")
local GameState = class("GameState", State)

function GameState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
    
    local playercontrol = PlayerControlSystem()
    self.engine:addSystem(TargetingSystem(), "update", 1)
    self.engine:addSystem(AccelerationSystem(), "update", 2)
    self.engine:addSystem(MovementSystem(), "update", 3)
    self.engine:addSystem(RotationSystem(), "update", 4)
    self.engine:addSystem(WeaponSystem(), "update", 5)
    self.engine:addSystem(FacingSystem(), "update", 6)
    self.engine:addSystem(TargetMoveSystem(), "update", 7)
    self.engine:addSystem(playercontrol, "update", 8)
    self.engine:addSystem(ExplodeOnContactSystem(), "update", 9)
    self.engine:addSystem(ParticleUpdateSystem(), "update", 10)    
    self.engine:addSystem(ParticlePositionSyncSystem(), "update", 11)

    local cameraSystem = CameraSystem()
    self.engine:addSystem(cameraSystem, "update", 10)

    -- has to be first to translate the coordinate system
    self.engine:addSystem(cameraSystem, "draw", 1)

    self.engine:addSystem(StringDrawSystem(), "draw", 2)
    self.engine:addSystem(DrawSystem(), "draw", 3)
    self.engine:addSystem(ParticleDrawSystem(), "draw", 4)

    self.eventmanager:addListener("KeyPressed", {playercontrol, playercontrol.fireEvent})
    self.eventmanager:addListener("KeyReleased", {playercontrol, playercontrol.fireEvent})

    local bg = Entity()
    bg:add(Drawable(resources.images.bg))
    bg:add(Transformable(Vector(0, 0)))
    self.engine:addEntity(bg)
    
    -- PlayerCreation
    player = PlayerModel()
    self.engine:addEntity(player)

    -- EnemyCreation
    for i=0, 10 do
        local enemy =  EnemyModel(math.random(100, 1200),math.random(100, 700))
        self.engine:addEntity(enemy)
    end

    -- DebugStrings
    local posstring = Entity()
    posstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Position %i %i", {{player:get("Transformable").position, "x"},{player:get("Transformable").position, "y"}} ))
    posstring:add(Transformable(Vector(50,50)))
    self.engine:addEntity(posstring)

    local speedstring = Entity()
    speedstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Speed %i %i", {{player:get("Moving").speed, "x"}, {player:get("Moving").speed, "y"}} ))
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
