local Damaging = class("Damaging", Component)

function Damaging:__init(damage)
    self.damage = damage
end

return Damaging
