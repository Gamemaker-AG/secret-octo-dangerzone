local DamageDone = class("DamageDone")

function DamageDone:__init(damage, target)
    self.damage = damage
    self.target = target
end

return DamageDone
