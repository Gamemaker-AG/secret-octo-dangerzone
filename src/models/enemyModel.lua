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
local Faction = require("components/gameplay/faction")
local LookingAt = require("components/gameplay/lookingAt")
local MovingTo = require("components/gameplay/movingTo")

local EnemyModel = class("EnemyModel", Entity)

function EnemyModel:__init(x, y)
    self:add(Transformable(Vector(x, y), Vector(1, 0)))
    self:add(Moving(Vector(0,0), constants.enemy.maxSpeed))
    self:add(Rotating(constants.enemy.defaultRotationSpeed))
    self:add(Accelerating(constants.enemy.defaultAcceleration, Vector(0,0)))
    self:add(LookingAt())
    self:add(MovingTo())
    self:add(Faction("enemy", {player=1}))

    local func = function() end
    self:add(Weapon(func, 0, 2, 2000, nil))

    local ship = resources.images.circle
    local sx, sy = constants.enemy.width/ship:getWidth()/5, constants.enemy.height/ship:getHeight()/5
    local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    self:add(Drawable(ship, 0, sx, sy, ox, oy))
end

return EnemyModel
