local Moving = require("components/physic/Moving")
local Transformable = require("components/physic/Transformable")
local Circle = require("components/physic/Circle")

local Damaging = require("components/gameplay/Damaging")
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")

local constants = require("constants")

function createProjectileCollection(entity, pos, target, damage, precision)
    -- Physic components
    entity:add(Transformable(pos:clone()))
        -- Getting direction and setting speed
    local direction = target:get("Transformable").position:subtract(pos):getUnit()

    if (precision and precision ~= 0) then
        local randomDirection = math.random(-1/2*precision, 1/2*precision)
        direction:set(direction:rotate(randomDirection*math.pi/180))
    end

    entity:add(Moving(direction:multiply(constants.bullet.speed)))
    entity:get("Transformable").direction:set(direction)

    entity:add(Circle(constants.bullet.diameter/2))

    -- Meta components
    entity:add(Damaging(damage))
    entity:add(ExplodesOnContact(target, target:get("Circle").radius))

    -- Graphics components
    local image = resources.images.beam
    local ox, oy = image:getWidth()/2, image:getHeight()/2
    entity:add(Drawable(image, 1, sx, sy, ox, oy))

    return entity
end

return createProjectileCollection
