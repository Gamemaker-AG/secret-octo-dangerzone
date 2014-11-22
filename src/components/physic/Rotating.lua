local Vector = require("helper/Vector")

local Rotating = class("Rotating", Component)

function Rotating:__init(defaultRotationSpeed)
    self.defRotationSpeed = defaultRotationSpeed
    self.rotationSpeed = 0
end

return Rotating