local Vector = require("helper/Vector")

local Transformable = Component.create("Transformable")

function Transformable:initialize(offset, dir, rotflag)
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
