-- Graphic Components
local PositionComponent = require("components/physic/positionComponent")
local DrawableComponent = require("components/graphic/drawableComponent")
local ZIndex = require("components/graphic/zIndex")

-- Physic Components
local SpeedComponent = require("components/physic/speedComponent")
local AccelerationComponent = require("components/physic/accelerationComponent")

local PlayerComponent = require("components/player/playerComponent")


local PlayerModel = class("PlayerModel", Entity)

function PlayerModel:__init()
    self:add(PlayerComponent())
    self:add(PositionComponent(10, 10))
    self:add(SpeedComponent())
    self:add(AccelerationComponent())
    self:add(DrawableComponent(resources.images.circle))
    self:add(ZIndex(1))
end

return PlayerModel
