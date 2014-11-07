-- Graphic components
local DrawableComponent = require("components/graphic/drawableComponent")
local ZIndex = require("components/graphic/zIndex")

-- Physic components
local SpeedComponent = require("components/physic/speedComponent")
local PositionComponent = require("components/physic/positionComponent")
local AccelerationComponent = require("components/physic/accelerationComponent")

local PlayerComponent = require("components/player/playerComponent")


local PlayerModel = class("PlayerModel", Entity)

function PlayerModel:__init()
    self:add(PlayerComponent())
    self:add(PositionComponent(10, 10))
    self:add(SpeedComponent(0, 50))
    self:add(AccelerationComponent(10))
    self:add(DrawableComponent(resources.images.circle))
    self:add(ZIndex(1))
end

return PlayerModel
