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
    local components = {}
    -- Physic components
    table.insert(components, Transformable(offset, nil, true))
    table.insert(components, Rotating(constants.turret.defaultRotationSpeed))
    local circle = Circle(constants.turret.diameter/2)
    table.insert(components, circle)

    -- Meta components
    table.insert(components, LookingAt())
    table.insert(components, Attitude({Pirate=1}))
    table.insert(components, Weapon(1000, nil))
    table.insert(components, ShootsProjectile(10, 2, 20, 10, 0.05, 0.02))

    -- Graphic components
    local turret = resources.images.circle
    local ox, oy = turret:getWidth()/2, turret:getHeight()/2
    table.insert(components, Drawable(turret, 2, sx, sy, ox, oy))

    local menu = TurretMenu(turret, circle)
    table.insert(components, Clickable(function() menu:toggle() end))

    return components
end

return createTurretCollection
