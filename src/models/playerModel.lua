-- Core
local Vector = require("helper/vector")

-- Graphic components
local DrawableComponent = require("components/graphic/drawableComponent")
local ZIndex = require("components/graphic/zIndex")

-- Physic components
local SpeedComponent = require("components/physic/speedComponent")
local PositionComponent = require("components/physic/positionComponent")

-- Player
local PlayerComponent = require("components/player/playerComponent")


local PlayerModel = class("PlayerModel", Entity)

function PlayerModel:__init()
    self:add(PlayerComponent())
    self:add(PositionComponent(Vector(100, 100), Vector(1, 0)))
    self:add(SpeedComponent(Vector(0,0), 50, math.pi/180*20, 10))
    local ship = resources.images.circle
    self:add(DrawableComponent(ship, 0, 1, 1, ship:getWidth()/2, ship:getHeight()/2))
    self:add(ZIndex(1))
end

return PlayerModel
