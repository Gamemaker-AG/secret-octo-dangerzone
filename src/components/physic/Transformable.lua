local Vector = require("helper/Vector")

local Transformable = class("Transformable", Component)

function Transformable:__init(offset, dir, rotflag)
    self.offset = offset or Vector()

    self.position = Vector()
    self.direction = dir or Vector()
    if rotflag == nil then
    	self.rotationEnabled = true
    else
    	self.rotationEnabled = rotflag
    end
end


return Transformable
