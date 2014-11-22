-- Models
local PlayerModel = require("models/PlayerModel")
local EnemyModel = require("models/EnemyModel")
local ButtonModel = require("models/ButtonModel")

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
local TransformableUpdateSystem = require("systems/physic/TransformableUpdateSystem")

-- Gameplay 
local WeaponSystem = require("systems/gameplay/WeaponSystem")
local FacingSystem = require("systems/gameplay/FacingSystem")
local TargetingSystem = require("systems/gameplay/TargetingSystem")
local TargetMoveSystem = require("systems/gameplay/TargetMoveSystem")
local PlayerControlSystem = require("systems/gameplay/PlayerControlSystem")
local ExplodeOnContactSystem = require("systems/gameplay/ExplodeOnContactSystem")

-- UI
local ClickableSystem = require("systems/ui/ClickableSystem")

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

    local clickableSystem = ClickableSystem()
    self.engine:addSystem(clickableSystem)
    self.eventmanager:addListener("MouseReleased", {clickableSystem, clickableSystem.mouseReleased})

    local bg = Entity()
    bg:add(Drawable(resources.images.bg))
    bg:add(Transformable(Vector(0, 0)))
    self.engine:addEntity(bg)
    
    -- PlayerCreation
    player = PlayerModel()
    self.engine:addEntity(player)

    local testButton = ButtonModel()
    self.engine:addEntity(testButton)

    -- EnemyCreation
    for i=0, 10 do
        local enemy = EnemyModel(math.random(100, 1200),math.random(100, 700))
        self.engine:addEntity(enemy)
    end

    -- DebugStrings
    local posstring = Entity()
    posstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Position %i %i", {{player:get("Transformable").position, "x"},{player:get("Transformable").position, "y"}} ))
    posstring:add(Transformable(Vector(50,50),nil,player))
    self.engine:addEntity(posstring)

    local speedstring = Entity()
    speedstring:add(DrawableText(resources.fonts.regular, {255, 255, 255, 255}, "Player's Speed %i %i", {{player:get("Moving").speed, "x"}, {player:get("Moving").speed, "y"}} ))
    speedstring:add(Transformable(Vector(50,100),nil,player))
    self.engine:addEntity(speedstring)
end

function GameState:update(dt)
    self.engine:update(dt)
end

function GameState:draw()
    self.engine:draw()
end

return GameState
