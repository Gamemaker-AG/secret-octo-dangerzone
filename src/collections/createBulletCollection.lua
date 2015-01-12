local Moving = require("components/physic/Moving")
local Transformable = require("components/physic/Transformable")

local Damaging = require("components/gameplay/Damaging")
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")

local constants = require("constants")

function createBulletCollection(entity, pos, target, damage)
    -- Physic components
    entity:add(Transformable(pos:clone()))
        -- Getting direction and setting speed
    local direction = target:get("Transformable").position:subtract(pos):getUnit()
    entity:add(Moving(direction:multiply(constants.bullet.speed)))
    entity:get("Transformable").direction:set(direction)


    -- Meta components
    entity:add(Damaging(damage))
    entity:add(ExplodesOnContact(target, 100))


    -- Graphics components
    local image = resources.images.beam
    local sx, sy = constants.bullet.diameter/image:getWidth(), constants.bullet.diameter/image:getHeight()
    local ox, oy = image:getWidth()/2, image:getHeight()/2
    entity:add(Drawable(image, 1, sx, sy, ox, oy))

    return entity
end

return createBulletCollection
