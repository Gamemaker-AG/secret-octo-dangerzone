local Weapon = class("Weapon", Component)

function Weapon:__init(fire, damage, cooldown, range, target) 
    self.fire = fire
    self.damage = damage
    self.defaultCooldown = cooldown
    self.range = range
    self.target = target or nil
    self.cooldown = 0
end

return Weapon
