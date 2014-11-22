-- Core
local Vector = require("helper/vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/drawable")
local Particle = require("components/particle/particle")
-- Physic components
local Moving = require("components/physic/moving")
local Rotating = require("components/physic/rotating")
local Accelerating = require("components/physic/accelerating")
local Transformable = require("components/physic/transformable")

-- Gameplay components
local Weapon = require("components/gameplay/weapon")
local Controllable = require("components/gameplay/controllable")
local Faction = require("components/gameplay/faction")
local Camera = require("components/gameplay/camera")

local PlayerModel = class("PlayerModel", Entity)


function PlayerModel:__init()
    self:add(Transformable(Vector(100, 100), Vector(1, 0)))
    self:add(Moving(Vector(0,0), constants.player.maxSpeed))
    self:add(Rotating(constants.player.defaultRotationSpeed))
    self:add(Accelerating(constants.player.defaultAcceleration, Vector(0,0)))
    self:add(Faction("player", {enemy=1}))

    local particleComponent = Particle(resources.images.particle1, 1000, Vector(-100, 0), {0.2, 1.2}, nil)
    self:add(particleComponent)
    particle = particleComponent.particle
    particle:setEmissionRate(1000)
    particle:setSpeed(300, 600)
    particle:setAreaSpread("normal",7,7)
    particle:setSpread(math.pi/32)
    particle:setParticleLifetime(0.01, 0.1)
    particle:setColors(50,50,255,100,0,0,100,150, 0,0,50,50)
    particle:start()

    local camera = Entity()
    camera:add(Camera(self))
    stack:current().engine:addEntity(camera)

    local ship = resources.images.player
    local sx, sy = constants.player.diameter/ship:getWidth(), constants.player.diameter/ship:getHeight()
    local ox, oy = ship:getWidth()*(2/3), ship:getHeight()/2
    self:add(Drawable(ship, 0, sx, sy, ox, oy))
    self:add(Controllable())
end

return PlayerModel
