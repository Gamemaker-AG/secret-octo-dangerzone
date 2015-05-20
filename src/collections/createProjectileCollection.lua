Component.load({"Moving", "Transformable", "Circle", "Damaging", "ExplodesOnContact", "Drawable"})

local constants = require("constants")

function createProjectileCollection(pos, target, damage, precision)
    local components = {}
    -- Physic components
    local transformable = Transformable(pos:clone())
    table.insert(components, transformable)
        -- Getting direction and setting speed
    local direction = target:get("Transformable").position:subtract(pos):getUnit()

    if (precision and precision ~= 0) then
        local randomDirection = math.random(-1/2*precision, 1/2*precision)
        direction:set(direction:rotate(randomDirection*math.pi/180))
    end

    table.insert(components, Moving(direction:multiply(constants.bullet.speed)))
    transformable.direction:set(direction)

    table.insert(components, Circle(constants.bullet.diameter/2))

    -- Meta components
    table.insert(components, Damaging(damage))
    table.insert(components, ExplodesOnContact(target, target:get("Circle").radius))

    -- Graphics components
    local image = resources.images.beam
    local ox, oy = image:getWidth()/2, image:getHeight()/2
    table.insert(components, Drawable(image, 1, sx, sy, ox, oy))

    return components
end

return createProjectileCollection
