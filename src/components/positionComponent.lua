PositionComponent = class("PositionComponent", Component)

function PositionComponent:__init(x, y)
    self.x = x or 0
    self.y = y or 0
end
