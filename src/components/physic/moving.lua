local Vector = require("helper/vector")

local Moving = class("Moving", Component)

function Moving:__init(speed, maxSpeed)
    self.speed = speed or Vector()
    self.maxSpeed = maxSpeed
end

return Moving
