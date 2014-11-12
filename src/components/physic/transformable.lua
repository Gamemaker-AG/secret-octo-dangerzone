local Vector = require("helper/vector")

local Transformable = class("Transformable", Component)

function Transformable:__init(position, dir, origin)
    self.position = position or Vector()
    self.direction = dir or Vector()

    self.origin = origin or Vector(0, 0)
end

return Transformable
