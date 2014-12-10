local Vector = require("helper/Vector")

local Transformable = class("Transformable", Component)

function Transformable:__init(offset, dir)
    self.offset = offset or Vector()

    self.position = Vector()
    self.direction = dir or Vector()
end


return Transformable
