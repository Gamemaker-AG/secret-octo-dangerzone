local DamageDone = class("DamageDone")

function DamageDone:initialize(damage, target)
    self.damage = damage
    self.target = target
end

return DamageDone
