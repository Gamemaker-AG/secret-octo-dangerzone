-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")

-- Physic components
local Rotating = require("components/physic/Rotating")
local Transformable = require("components/physic/Transformable")
local Diameter = require("components/physic/Diameter")

-- Gameplay components
local Weapon = require("components/gameplay/Weapon")
local Attitude = require("components/gameplay/Attitude")
local LookingAt = require("components/gameplay/LookingAt")

-- Models
local Enemy = require("models/PirateModel")
local Bullet = require("models/BulletModel")
local TurretMenu = require("models/ui/TurretMenu")

local TurretModel = class("TurretModel", Entity)

function TurretModel:__init(offset, parent)
    self:add(Diameter(constants.turret.diameter))

    if parent then
        self:setParent(parent)
    else parent = nil end
    
    self:add(Transformable(offset, nil))
    self:add(Rotating(constants.turret.defaultRotationSpeed))
    self:add(Attitude({Pirate=1}))
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

    local menu = TurretMenu(self)
    self:add(Clickable(function() menu:toggle() end))
end

return TurretModel
