-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")

-- Physic components
local Moving = require("components/physic/Moving")
local Rotating = require("components/physic/Rotating")
local Accelerating = require("components/physic/Accelerating")
local Transformable = require("components/physic/Transformable")

-- Gameplay components
local Hull = require("components/gameplay/Hull")
local Weapon = require("components/gameplay/Weapon")
local Attitude = require("components/gameplay/Attitude")
local MovingTo = require("components/gameplay/MovingTo")
local LookingAt = require("components/gameplay/LookingAt")
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")
local Wave = require("components/gameplay/Wave")
local DropsGold = require("components/gameplay/DropsGold")

local Rocket = require("models/RocketModel")
local Pirate = require("components/meta/Pirate")

local PirateModel = class("PirateModel", Entity)

function PirateModel:__init(x, y)
    self:add(Transformable(Vector(x, y), Vector(1, 0)))
    self:add(Moving(Vector(0,0), constants.enemy.maxSpeed))
    self:add(Rotating(constants.enemy.defaultRotationSpeed))
    self:add(Accelerating(constants.enemy.defaultAcceleration, Vector(0,0)))
    self:add(LookingAt())
    self:add(Hull(20))
    self:add(MovingTo())
    self:add(Attitude({Player=1}))
    self:add(Wave())
    self:add(DropsGold(1))
    self:add(Pirate())

    local player = table.firstElement(stack:current().engine:getEntityList("Player"))
    if player then self:add(ExplodesOnContact(player, constants.player.diameter/2)) end

    local func = function(entity, target)
        stack:current().engine:addEntity(Rocket(entity:get("Transformable").position, target, 10))
    end
    --||-- Why no constants? fire, damage, cooldown, range, target
    self:add(Weapon(func, 10, 2, 2000, nil))

    local ship = resources.images.enemy
    local sx, sy = constants.enemy.diameter/ship:getWidth(), constants.enemy.diameter/ship:getHeight()
    local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    self:add(Drawable(ship, 0, sx, sy, ox, oy))
end

return PirateModel
