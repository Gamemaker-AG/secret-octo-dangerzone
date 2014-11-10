local TransformComponent = class("TransformComponent", Component)

function TransformComponent:__init(position, dir)
    self.position = position or Vector()
    self.direction = dir or Vector()
end

return TransformComponent
