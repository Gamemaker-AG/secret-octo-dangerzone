-- Models
local ButtonModel = require("models/ButtonModel")
local PirateModel = require("models/PirateModel")
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
local DebrisDestroySystem = require("systems/gameplay/DebrisDestroySystem")
local ParallaxSystem = require("systems/draw/ParallaxSystem")
local GoldSystem = require("systems/gameplay/GoldSystem")
local DamageSystem = require("systems/gameplay/DamageSystem")
local ShieldSystem = require("systems/gameplay/ShieldSystem")

-- UI
local ClickableSystem = require("systems/ui/ClickableSystem")

-- Events
local KeyPressed = require("events/KeyPressed")
local KeyReleased = require("events/KeyReleased")
local DamageDone = require("events/DamageDone")
local UpdateTransformable = require("events/UpdateTransformable")
local UpdateParticlePosition = require("events/UpdateParticlePosition")

-- Components
local DrawableText = require("components/graphic/DrawableText")
local Transformable = require("components/physic/Transformable")
local Parallax = require("components/gameplay/Parallax")

-- Helper
local Vector = require("helper/Vector")

-- State superclass
local State = require("core/State")
local GameState = class("GameState", State)

function GameState:load()
    self.engine = Engine()
    self.engine:getRootEntity():add(Transformable())
    self.eventmanager = EventManager()

    -- Systems containing update and draw
    local shieldSystem = ShieldSystem()
    local cameraSystem = CameraSystem()
    
    -- Systems containing an event function
    local playercontrol = PlayerControlSystem()
    local transformableUpdateSystem = TransformableUpdateSystem()
    local particlePositionSyncSystem = ParticlePositionSyncSystem()

    -- Pure event systems
    local damagesystem = DamageSystem()
    local goldsystem = GoldSystem()

    -- Adding update systems
    self.engine:addSystem(DestroySystem())
    self.engine:addSystem(transformableUpdateSystem)
    self.engine:addSystem(AccelerationSystem())
    self.engine:addSystem(MovementSystem())
    self.engine:addSystem(RotationSystem())
    self.engine:addSystem(WeaponSystem())
    self.engine:addSystem(FacingSystem())
    self.engine:addSystem(TargetMoveSystem())
    self.engine:addSystem(playercontrol)
    self.engine:addSystem(ExplodeOnContactSystem())
    self.engine:addSystem(ParticleUpdateSystem())    
    self.engine:addSystem(particlePositionSyncSystem)
    self.engine:addSystem(TargetingSystem())
    self.engine:addSystem(MuzzleparticlesSystem())
    self.engine:addSystem(WavesSystem())
    self.engine:addSystem(DebrisDestroySystem())
    self.engine:addSystem(shieldSystem, "update")
    self.engine:addSystem(cameraSystem, "update")

    -- Adding draw systems
    -- Camera system has to be first to translate the coordinate system
    self.engine:addSystem(cameraSystem, "draw")

    self.engine:addSystem(DrawSystem())
    self.engine:addSystem(ParticleDrawSystem())
    self.engine:addSystem(StringDrawSystem())
    self.engine:addSystem(ParallaxSystem())
    self.engine:addSystem(shieldSystem, "draw")

    -- Adding passive systems
    self.engine:addSystem(goldsystem)

    -- Registering event listeners
    self.eventmanager:addListener("KeyPressed", {playercontrol, playercontrol.fireEvent})
    self.eventmanager:addListener("KeyReleased", {playercontrol, playercontrol.fireEvent})

    self.eventmanager:addListener("AddingGold", {goldsystem, goldsystem.addGold})
    self.eventmanager:addListener("DamageDone", {damagesystem, damagesystem.fireEvent})
    self.eventmanager:addListener("UpdateTransformable", {transformableUpdateSystem, transformableUpdateSystem.onDemandUpdate})
    self.eventmanager:addListener("UpdateParticlePosition", {particlePositionSyncSystem, particlePositionSyncSystem.updatePosition})

    -- Adding Initializer to Engine
    self.engine:addInitializer("Transformable",
        function(entity)
            stack:current().eventmanager:fireEvent(UpdateTransformable(entity))
            if entity:has("Particle") then
                stack:current().eventmanager:fireEvent(UpdateParticlePosition(entity))
            end
        end
    )

    -- Adding deepfield entity
    local deepfield = Entity()
    deepfield:add(Drawable(resources.images.deepfield))
    deepfield:add(Transformable(Vector(0, 0)))
    deepfield:add(Parallax(1.5))
    self.engine:addEntity(deepfield)

    -- Adding background 1
    local bg = Entity()
    bg:add(Drawable(resources.images.bg))
    bg:add(Transformable(Vector(0, 0)))
    bg:add(Parallax(1.6))
    self.engine:addEntity(bg)

    -- Adding background 2
    local bg = Entity()
    bg:add(Drawable(resources.images.bg))
    bg:add(Transformable(Vector(0, 0)))
    bg:add(Parallax(1.7))
    self.engine:addEntity(bg)
    
    -- Adding player entity
    self.player = PlayerModel()
    self.engine:addEntity(self.player)


    -- Adding player turret
    local turret = TurretModel(Vector(30, 0), self.player)
    self.engine:addEntity(turret)

    -- Adding Hull and Shield string entity

    local hull = Entity()
    hull:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's hull: %i", {{self.player:get("Hull"), "hitpoints"}}))
    hull:add(Transformable(Vector(10,10),nil))
    self.engine:addEntity(hull)

    local shield = Entity()
    shield:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's shield: %i", {{self.player:get("Shield"), "hitpoints"}}))
    shield:add(Transformable(Vector(10,30),nil))
    self.engine:addEntity(shield)


    -- Debug strings
    local posstring = Entity(self.player)
    posstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Position %i %i", {{self.player:get("Transformable").position, "x"},{self.player:get("Transformable").position, "y"}} ))
    posstring:add(Transformable(Vector(50,50),nil))
    self.engine:addEntity(posstring)

    local speedstring = Entity(self.player)
    speedstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Speed %i %i", {{self.player:get("Moving").speed, "x"}, {self.player:get("Moving").speed, "y"}} ))
    speedstring:add(Transformable(Vector(50,100),nil))
    self.engine:addEntity(speedstring)

    local goldstring = Entity(self.player)
    goldstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Gold %i", {{self.player:get("HasGold"), "gold"}} ))
    goldstring:add(Transformable(Vector(100, 100),nil))
    self.engine:addEntity(goldstring)
end

function GameState:update(dt)
    self.engine:update(dt)
end

function GameState:draw()
    self.engine:draw()
end

return GameState
