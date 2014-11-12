local Weapon = class("Weapon", Component)

function Weapon:__init(fire, damage, cooldown, target) 
    self.fire = fire
    self.target = target or nil
    self.damage = damage
    self.cooldown = 0
    self.defaultCooldown = cooldown
end

return Weapon
