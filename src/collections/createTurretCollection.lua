local Description, Drawable, Rotating, Circle, Transformable, Weapon, Attitude, LookingAt, ShootsProjectile, Clickable = 
    Component.load({"Description", "Drawable", "Rotating", "Circle", "Transformable", "Weapon", "Attitude", "LookingAt", "ShootsProjectile", "Clickable"})

local Vector = require("helper/Vector")

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
    table.insert(components, Description(constants.turret.name, constants.turret.description))

    -- Graphic components
    local turret = resources.images.circle
    local ox, oy = turret:getWidth()/2, turret:getHeight()/2
    table.insert(components, Drawable(turret, 2, sx, sy, ox, oy))

    return components
end

return createTurretCollection
