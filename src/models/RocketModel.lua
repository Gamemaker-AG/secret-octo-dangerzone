local Moving = require("components/physic/Moving")
local Transformable = require("components/physic/Transformable")

local Damaging = require("components/gameplay/Damaging")
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")

local constants = require("constants")

local Rocket = class("Rocket", Entity)

function Rocket:__init(pos, target, damage)
    self:add(Damaging(damage))
    self:add(ExplodesOnContact(target, 100))

    self:add(Transformable(pos:clone()))

    local image = resources.images.circle
    local sx, sy = constants.rocket.diameter/image:getWidth(), constants.rocket.diameter/image:getHeight()
    local ox, oy = image:getWidth()/2, image:getHeight()/2
    self:add(Drawable(image, 0, sx, sy, ox, oy))

    local direction = target:get("Transformable").position:subtract(pos):getUnit()
    self:add(Moving(direction:multiply(constants.rocket.speed)))

end

return Rocket
