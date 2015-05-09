-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")

-- Physic components
local Rotating = require("components/physic/Rotating")
local Transformable = require("components/physic/Transformable")
local Circle = require("components/physic/Circle")

-- Gameplay components
local Weapon = require("components/gameplay/Weapon")
local Attitude = require("components/gameplay/Attitude")
local LookingAt = require("components/gameplay/LookingAt")
local ShootsProjectile = require("components/gameplay/ShootsProjectile")

local TurretMenu = require("models/ui/TurretMenu")

function createTurretCollection(entity, offset)
    -- Physic components
    entity:add(Transformable(offset, nil, true))
    entity:add(Rotating(constants.turret.defaultRotationSpeed))
    entity:add(Circle(constants.turret.diameter/2))

    -- Meta components
    entity:add(LookingAt())
    entity:add(Attitude({Pirate=1}))
    entity:add(Weapon(1000, nil))
    entity:add(ShootsProjectile(10, 0.01, 0, 1))

    -- Graphic components
    local turret = resources.images.circle
    local ox, oy = turret:getWidth()/2, turret:getHeight()/2
    entity:add(Drawable(turret, 2, sx, sy, ox, oy))

    local menu = TurretMenu(entity)
    entity:add(Clickable(function() menu:toggle() end))

    return entity
end

return createTurretCollection
