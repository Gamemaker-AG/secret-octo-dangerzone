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
local Attitude = require("components/gameplay/Attitude")
local LookingAt = require("components/gameplay/LookingAt")

-- Collection
local createBulletCollection = require("collections/createBulletCollection")

function createTurretCollection(entity, offset)
    -- Physic components
    entity:add(Transformable(offset, nil, true))
    entity:add(Rotating(constants.turret.defaultRotationSpeed))

    -- Meta components
    entity:add(LookingAt())
    entity:add(Attitude({Pirate=1}))

        -- Creating weapon function
    local func = function(entity, target)
        local damage = entity:get("Weapon").damage
        local position = entity:get("Transformable").position
        stack:current().engine:addEntity(createBulletCollection(Entity(), position, target, damage))
    end
    entity:add(Weapon(func, 10, 0.5, 2000, nil))

    -- Graphic components
    local turret = resources.images.circle
    local sx, sy = constants.turret.diameter/turret:getWidth(), constants.turret.diameter/turret:getHeight()
    local ox, oy = turret:getWidth()/2, turret:getHeight()/2
    entity:add(Drawable(turret, 2, sx, sy, ox, oy))

    return entity
end

return createTurretCollection
