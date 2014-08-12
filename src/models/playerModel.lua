require("components/positionComponent")
require("components/drawableComponent")

PlayerModel = class("PlayerModel", Entity)

function PlayerModel:__init()
    self:add(PositionComponent(10, 10))
    self:add(DrawableComponent(resources.images.circle))
end
