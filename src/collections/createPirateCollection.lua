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

function createPirateCollection(x, y)
    local components = {}
    -- Physical components
    table.insert(components, Transformable(Vector(x, y), Vector(1, 0)))
    table.insert(components, Moving(Vector(0,0), constants.enemy.maxSpeed))
    table.insert(components, Rotating(constants.enemy.defaultRotationSpeed))
    table.insert(components, Accelerating(constants.enemy.defaultAcceleration, Vector(0,0)))
    table.insert(components, Circle(constants.enemy.diameter/2))

    -- Meta
    table.insert(components, Wave())
    table.insert(components, Pirate())
    table.insert(components, MovingTo())
    table.insert(components, LookingAt())
    table.insert(components, Attitude({Player=1}))

    -- Gameplay
    table.insert(components, Hull(20))
    table.insert(components, DropsGold(1))

    -- Creating weapon component
    -- Getting Target for weapon component
    local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
    if player then table.insert(components, ExplodesOnContact(player, 0)) end

    table.insert(components, (Weapon(2000, nil)))

    -- Graphic components
    local ship = resources.images.enemy
    local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    table.insert(components, Drawable(ship, 1, sx, sy, ox, oy))

    return components
end

return createPirateCollection
