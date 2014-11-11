-- Core
local Vector = require("helper/vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/drawable")

-- Physic components
local Controllable = require("components/physic/controllable")
local Transformable = require("components/physic/transformable")
local Moving = require("components/physic/moving")
local Rotating = require("components/physic/rotating")
local Accelerating = require("components/physic/accelerating")

local PlayerModel = class("PlayerModel", Entity)

function PlayerModel:__init()
    self:add(Transformable(Vector(100, 100), Vector(1, 0)))
    self:add(Moving(Vector(0,0), 200))
    self:add(Rotating(math.pi/180*40))
    self:add(Accelerating(40, Vector(0,0)))

    local ship = resources.images.circle
    local sx, sy = constants.player.width/ship:getWidth(), constants.player.height/ship:getHeight()
    local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    self:add(Drawable(ship, 0, sx, sy, ox, oy))
    self:add(Controllable())
end

return PlayerModel
