local Transformable = require("components/physic/transformable")
local ExplodesOnContact = require("components/gameplay/explodesOnContact")
local Moving = require("components/physic/moving")

local constants = require("constants")

local Bullet = class("Bullet", Entity)

function Bullet:__init(pos, target)
    self:add(Transformable(pos:clone()))

    local image = resources.images.circle
    local sx, sy = constants.bullet.diameter/image:getWidth(), constants.bullet.diameter/image:getHeight()
    local ox, oy = image:getWidth()/2, image:getHeight()/2
    self:add(Drawable(image, 0, sx, sy, ox, oy))

    local direction = target:get("Transformable").position:subtract(pos):getUnit()
    self:add(Moving(direction:multiply(constants.bullet.speed)))

    self:add(ExplodesOnContact(target, 100))
end

return Bullet
