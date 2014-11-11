-- Core
local Vector = require("helper/vector")

-- Graphic components
local DrawableComponent = require("components/graphic/drawableComponent")
local ZIndex = require("components/graphic/zIndex")

-- Physic components
local ControllableComponent = require("components/physic/controllableComponent")
local SpeedComponent = require("components/physic/speedComponent")
local TransformComponent = require("components/physic/transformComponent")

local PlayerModel = class("PlayerModel", Entity)

function PlayerModel:__init()
    self:add(TransformComponent(Vector(100, 100), Vector(1, 0)))
    self:add(SpeedComponent(Vector(0,0), 200, math.pi/180*40, 40, Vector(0,0)))
    local ship = resources.images.circle
    self:add(DrawableComponent(ship, 0, 1, 1, ship:getWidth()/2, ship:getHeight()/2))
    self:add(ControllableComponent())
    self:add(ZIndex(1))
end

return PlayerModel
