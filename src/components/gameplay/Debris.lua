local Debris = class("Debris", Component)

function Debris:__init(target, distance)
    self.target = target
    self.distance = distance
end

return Debris
