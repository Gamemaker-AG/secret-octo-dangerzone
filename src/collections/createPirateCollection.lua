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
local Circle = require("components/physic/Circle")

-- Gameplay components
local Hull = require("components/gameplay/Hull")
local Wave = require("components/gameplay/Wave")
local Weapon = require("components/gameplay/Weapon")
local Attitude = require("components/gameplay/Attitude")
local MovingTo = require("components/gameplay/MovingTo")
local LookingAt = require("components/gameplay/LookingAt")
local DropsGold = require("components/gameplay/DropsGold")
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")

-- Meta
local Pirate = require("components/meta/Pirate")

-- Collection
local createRocketCollection = require("collections/createRocketCollection")

function createPirateCollection(entity, x, y)
    -- Physical components
    entity:add(Transformable(Vector(x, y), Vector(1, 0)))
    entity:add(Moving(Vector(0,0), constants.enemy.maxSpeed))
    entity:add(Rotating(constants.enemy.defaultRotationSpeed))
    entity:add(Accelerating(constants.enemy.defaultAcceleration, Vector(0,0)))
    entity:add(Circle(constants.enemy.diameter/2))

    -- Meta
    entity:add(Wave())
    entity:add(Pirate())
    entity:add(MovingTo())
    entity:add(LookingAt())
    entity:add(Attitude({Player=1}))

    -- Gameplay
    entity:add(Hull(20))
    entity:add(DropsGold(1))
        -- Creating weapon component
            -- Getting Target for weapon component
    local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
    if player then entity:add(ExplodesOnContact(player, constants.player.diameter/2)) end


            -- Creating Function for weapon component
    local WeaponFunction = function(entity, target)
        stack:current().engine:addEntity(createRocketCollection(Entity(), entity:get("Transformable").position, target, 10))
    end
    entity:add(Weapon(WeaponFunction, 10, 2, 2000, nil))

    -- Graphic components
    local ship = resources.images.enemy
    local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    entity:add(Drawable(ship, 1, sx, sy, ox, oy))

    return entity
end

return createPirateCollection
