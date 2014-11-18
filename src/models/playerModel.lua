-- Core
local Vector = require("helper/vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/drawable")

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

    local ship = resources.images.circle
    local sx, sy = constants.player.diameter/ship:getWidth(), constants.player.diameter/ship:getHeight()
    local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    self:add(Drawable(ship, 0, sx, sy, ox, oy))
    self:add(Controllable())
end

return PlayerModel
