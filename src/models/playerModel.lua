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

local PlayerModel = class("PlayerModel", Entity)


function PlayerModel:__init()
    self:add(Transformable(Vector(100, 100), Vector(1, 0)))
    self:add(Moving(Vector(0,0), constants.player.maxSpeed))
    self:add(Rotating(constants.player.defaultRotationSpeed))
    self:add(Accelerating(constants.player.defaultAcceleration, Vector(0,0)))
    self:add(Faction("player", {enemy=1}))
    self:add(Particle(resources.images.particlemuzzle , 100000, 2, 100000))
    self:get("Particle").particle:setSpeed(1, 1)
    self:get("Particle").particle:setEmissionRate(10000)

    local ship = resources.images.player
    local sx, sy = constants.player.diameter/ship:getWidth(), constants.player.diameter/ship:getHeight()
    local ox, oy = ship:getWidth()*(2/3), ship:getHeight()/2
    self:add(Drawable(ship, 0, sx, sy, ox, oy))
    self:add(Controllable())
end

return PlayerModel
