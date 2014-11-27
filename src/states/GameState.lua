-- Models
local EnemyModel = require("models/EnemyModel")
local PlayerModel = require("models/PlayerModel")
local TurretModel = require("models/TurretModel")

-- Graphic systems
local DrawSystem = require("systems/draw/DrawSystem")
local StringDrawSystem = require("systems/draw/StringDrawSystem")
local CameraSystem = require("systems/draw/CameraSystem")
local MuzzleparticlesSystem = require("systems/draw/MuzzleparticlesSystem")

-- Particle systems 
local ParticleDrawSystem = require("systems/particle/ParticleDrawSystem")
local ParticlePositionSyncSystem = require("systems/particle/ParticlePositionSyncSystem")
local ParticleUpdateSystem = require("systems/particle/ParticleUpdateSystem")

-- Physic systems
local MovementSystem = require("systems/physic/MovementSystem")
local RotationSystem = require("systems/physic/RotationSystem")
local AccelerationSystem = require("systems/physic/AccelerationSystem")
local TransformableUpdateSystem = require("systems/physic/TransformableUpdateSystem")

-- Gameplay 
local WeaponSystem = require("systems/gameplay/WeaponSystem")
local FacingSystem = require("systems/gameplay/FacingSystem")
local TargetingSystem = require("systems/gameplay/TargetingSystem")
local DestroySystem = require("systems/gameplay/DestroySystem")
local TargetMoveSystem = require("systems/gameplay/TargetMoveSystem")
local PlayerControlSystem = require("systems/gameplay/PlayerControlSystem")
local ExplodeOnContactSystem = require("systems/gameplay/ExplodeOnContactSystem")
local WavesSystem = require("systems/gameplay/WavesSystem")

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
    self.engine:addSystem(DestroySystem())
    self.engine:addSystem(TransformableUpdateSystem())
    self.engine:addSystem(AccelerationSystem())
    self.engine:addSystem(MovementSystem())
    self.engine:addSystem(RotationSystem())
    self.engine:addSystem(WeaponSystem())
    self.engine:addSystem(FacingSystem())
    self.engine:addSystem(TargetMoveSystem())
    self.engine:addSystem(playercontrol)
    self.engine:addSystem(ExplodeOnContactSystem())
    self.engine:addSystem(ParticleUpdateSystem())    
    self.engine:addSystem(ParticlePositionSyncSystem())
    self.engine:addSystem(TargetingSystem())
    self.engine:addSystem(MuzzleparticlesSystem())
    self.engine:addSystem(WavesSystem())

    local cameraSystem = CameraSystem()
    self.engine:addSystem(cameraSystem, "update")

    -- has to be first to translate the coordinate system
    self.engine:addSystem(cameraSystem, "draw")

    self.engine:addSystem(DrawSystem())
    self.engine:addSystem(ParticleDrawSystem())
    self.engine:addSystem(StringDrawSystem())

    self.eventmanager:addListener("KeyPressed", {playercontrol, playercontrol.fireEvent})
    self.eventmanager:addListener("KeyReleased", {playercontrol, playercontrol.fireEvent})

    self.transformableRoot = Transformable()

    local bg = Entity()
    bg:add(Drawable(resources.images.bg))
    bg:add(Transformable(Vector(0, 0)))
    self.engine:addEntity(bg)
    
    -- PlayerCreation
    self.player = PlayerModel()
    self.engine:addEntity(self.player)

    local turret = TurretModel(Vector(30, 0), self.player)
    self.engine:addEntity(turret)

    -- EnemyCreation
    -- for i=0, 10 do
    --     local enemy = EnemyModel(math.random(100, 1200),math.random(100, 700))
    --     self.engine:addEntity(enemy)
    -- end

    -- DebugStrings
    local posstring = Entity()
    posstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Position %i %i", {{self.player:get("Transformable").position, "x"},{self.player:get("Transformable").position, "y"}} ))
    posstring:add(Transformable(Vector(50,50),nil,self.player))
    self.engine:addEntity(posstring)

    local speedstring = Entity()
    speedstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Speed %i %i", {{self.player:get("Moving").speed, "x"}, {self.player:get("Moving").speed, "y"}} ))
    speedstring:add(Transformable(Vector(50,100),nil,self.player))
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
