local Debris = Component.create("Debris")

function Debris:initialize(target, distance)
    self.target = target or stack:current().player
    self.distance = distance or constants.screenWidth
end

return Debris
