local PositionComponent = class("PositionComponent", Component)

function PositionComponent:__init(position, dir)
    self.position = position or Vector()
    self.direction = dir or Vector()
end

return PositionComponent
