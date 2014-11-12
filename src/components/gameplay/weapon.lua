local Weapon = class("Weapon", Component)

function Weapon:__init(rate, damage, typ, target) 
    self.typ = typ
    self.rate = rate
    self.target = target
    self.damage = damage
end

return Weapon
