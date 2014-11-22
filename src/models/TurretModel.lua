-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")

-- Physic components
local Rotating = require("components/physic/Rotating")
local Transformable = require("components/physic/Transformable")

-- Gameplay components
local Weapon = require("components/gameplay/Weapon")
local Faction = require("components/gameplay/Faction")
local LookingAt = require("components/gameplay/LookingAt")

-- Models
local Enemy = require("models/EnemyModel")
local Bullet = require("models/BulletModel")

local TurretModel = class("TurretModel", Entity)

function TurretModel:__init(offset, parent)
    self:add(Transformable(offset, nil, parent))
    self:add(Rotating(constants.turret.defaultRotationSpeed))
    self:add(Faction("player", {enemy=1}))
    local func = function(entity, target)
        stack:current().engine:addEntity(Bullet(entity:get("Transformable").position, target, entity:get("Weapon").damage))
    end
    --||-- Why no constants? fire, damage, cooldown, range, target
    self:add(Weapon(func, 10, 0.5, 2000, nil))
    self:add(LookingAt())


    local turret = resources.images.circle
    local sx, sy = constants.turret.diameter/turret:getWidth(), constants.turret.diameter/turret:getHeight()
    local ox, oy = turret:getWidth()/2, turret:getHeight()/2
    self:add(Drawable(turret, 10, sx, sy, ox, oy))
end

return TurretModel
