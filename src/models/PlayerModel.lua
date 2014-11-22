-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")
local Particle = require("components/particle/Particle")
-- Physic components
local Moving = require("components/physic/Moving")
local Rotating = require("components/physic/Rotating")
local Accelerating = require("components/physic/Accelerating")
local Transformable = require("components/physic/Transformable")

-- Gameplay components
local Weapon = require("components/gameplay/Weapon")
local Controllable = require("components/gameplay/Controllable")
local Faction = require("components/gameplay/Faction")
local Camera = require("components/gameplay/Camera")

local PlayerModel = class("PlayerModel", Entity)


function PlayerModel:__init()
    self:add(Transformable(Vector(100, 100), Vector(1, 0)))
    self:add(Moving(Vector(0,0), constants.player.maxSpeed))
    self:add(Rotating(constants.player.defaultRotationSpeed))
    self:add(Accelerating(constants.player.defaultAcceleration, Vector(0,0)))
    self:add(Faction("player", {enemy=1}))
    self:add(Particle(resources.images.particle1, 1000, {0.2, 1.2}, nil))
    local particle = self:get("Particle").particle
    particle:setEmissionRate(100)
    particle:setSpeed(10, 20)
    particle:setDirection(1)
    particle:setSpread(360)
    particle:setParticleLifetime(0.2, 1.2)
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
