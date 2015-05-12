-- Collections
local createPlayerCollection = require("collections/createPlayerCollection")
local createTurretCollection = require("collections/createTurretCollection")

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
local MapGenerationSystem = require("systems/physic/MapGenerationSystem")

-- Gameplay 
local ProjectileSystem = require("systems/gameplay/ProjectileSystem")
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
local DebugSystem = require("systems/gameplay/DebugSystem")
local Camera = require("components/gameplay/Camera")

-- UI
local ClickableSystem = require("systems/ui/ClickableSystem")
local SpaceStationActivateSystem = require("systems/ui/SpaceStationActivateSystem")

-- Events
local KeyPressed = require("events/KeyPressed")
local KeyReleased = require("events/KeyReleased")
local DamageDone = require("events/DamageDone")
local UpdateTransformable = require("events/UpdateTransformable")
local UpdateParticlePosition = require("events/UpdateParticlePosition")

-- Components
local DrawableText = require("components/graphic/DrawableText")
local Transformable = require("components/physic/Transformable")
local DebugText = require("components/graphic/DebugText")
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
    local debugsystem = DebugSystem()
    local clickableSystem = ClickableSystem()
    local spaceStationSystem = SpaceStationActivateSystem()

    -- Adding update systems
    self.engine:addSystem(spaceStationSystem)
    self.engine:addSystem(DestroySystem())
    self.engine:addSystem(AccelerationSystem())
    self.engine:addSystem(MovementSystem())
    self.engine:addSystem(RotationSystem())
    self.engine:addSystem(ProjectileSystem())
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
    self.engine:addSystem(clickableSystem)
    self.engine:addSystem(shieldSystem, "update")
    self.engine:addSystem(ParallaxSystem())
    self.engine:addSystem(cameraSystem, "update")
    self.engine:addSystem(transformableUpdateSystem)
    self.engine:addSystem(MapGenerationSystem())


    -- Adding draw systems
    -- Camera system has to be first to translate the coordinate system
    self.engine:addSystem(cameraSystem, "draw")

    self.engine:addSystem(DrawSystem())
    self.engine:addSystem(StringDrawSystem())
    self.engine:addSystem(ParticleDrawSystem())
    self.engine:addSystem(shieldSystem, "draw")

    -- Adding passive systems
    self.engine:addSystem(goldsystem)

    -- Debugsystem
    self.engine:addSystem(debugsystem, "update")
    self.engine:addSystem(debugsystem, "draw")

    -- Registering event listeners
    self.eventmanager:addListener("KeyPressed", spaceStationSystem, spaceStationSystem.keyPressed)
    self.eventmanager:addListener("KeyPressed", playercontrol, playercontrol.fireEvent)
    self.eventmanager:addListener("KeyPressed", debugsystem, debugsystem.setInvisibility)
    self.eventmanager:addListener("KeyReleased", playercontrol, playercontrol.fireEvent)

    -- self.eventmanager:addListener("AddingGold", goldsystem, goldsystem.addGold)
    self.eventmanager:addListener("DamageDone", damagesystem, damagesystem.fireEvent)
    self.eventmanager:addListener("UpdateTransformable", transformableUpdateSystem, transformableUpdateSystem.onDemandUpdate)
    self.eventmanager:addListener("UpdateParticlePosition", particlePositionSyncSystem, particlePositionSyncSystem.updatePosition)
    self.eventmanager:addListener("MouseReleased", clickableSystem, clickableSystem.mouseReleased)


    -- Adding Initializer to Engine
    self.engine:addInitializer("Transformable",
        function(entity)
            stack:current().eventmanager:fireEvent(UpdateTransformable(entity))
            if entity:has("Particle") then
                stack:current().eventmanager:fireEvent(UpdateParticlePosition(entity))
            end
        end
    )
    
    -- Adding player entity
    self.player = Entity()
    self.player:addMultiple(createPlayerCollection(Entity()))
    self.engine:addEntity(self.player)

    local camera = Entity()
    camera:add(Camera(self.player))
    camera:add(Transformable(self.player:get("Transformable").position:clone()))
    stack:current().engine:addEntity(camera)

    -- Adding player turret
    local turret = Entity(self.player)
    turret:addMultiple(createTurretCollection(turret, Vector(30, 0)))
    self.engine:addEntity(turret)

    -- Adding Hull and Shield string entity

    local hull = Entity(camera)
    hull:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's hull: %i", {{self.player:get("Hull"), "hitpoints"}}))
    hull:add(Transformable(Vector(10,10),nil))
    hull:add(DebugText())
    self.engine:addEntity(hull)

    local shield = Entity(camera)
    shield:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's shield: %i", {{self.player:get("Shield"), "hitpoints"}}))
    shield:add(Transformable(Vector(10,30),nil))
    shield:add(DebugText())
    self.engine:addEntity(shield)

    local fps = Entity(camera)
    fps:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "FPS: %i", {{debugsystem, "fps"}}))
    fps:add(Transformable(Vector(10,50),nil))
    fps:add(DebugText())
    self.engine:addEntity(fps)

    local ups = Entity(camera)
    ups:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "UPS: %i", {{debugsystem, "ups"}}))
    ups:add(Transformable(Vector(10,70),nil))
    ups:add(DebugText())
    self.engine:addEntity(ups)

    -- Debug strings
    local posstring = Entity(self.player)
    posstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Position %i %i", {{self.player:get("Transformable").position, "x"},{self.player:get("Transformable").position, "y"}} ))
    posstring:add(Transformable(Vector(50,50),nil, false))
    self.engine:addEntity(posstring)

    local speedstring = Entity(self.player)
    speedstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Speed %i %i", {{self.player:get("Moving").speed, "x"}, {self.player:get("Moving").speed, "y"}} ))
    speedstring:add(Transformable(Vector(50,100),nil, false))
    self.engine:addEntity(speedstring)

    local goldstring = Entity(self.player)
    goldstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Gold %i", {{self.player:get("HasGold"), "gold"}} ))
    goldstring:add(Transformable(Vector(50, 150),nil, false))
    self.engine:addEntity(goldstring)
end

function GameState:update(dt)
    self.engine:update(dt)
end

function GameState:draw()
    self.engine:draw()
end

return GameState
