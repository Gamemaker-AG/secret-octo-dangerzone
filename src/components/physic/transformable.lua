local Transformable = class("Transformable", Component)

function Transformable:__init(position, dir)
    self.position = position or Vector()
    self.direction = dir or Vector()
end

return Transformable
