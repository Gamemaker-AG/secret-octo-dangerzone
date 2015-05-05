local Projectile = class("Projectile", Component)

function Projectile:__init(damage, cooldown, precision, amount)
    self.damage = damage
    self.precision = precision or 0
    self.bulletAmount = amount or 1
    self.defaultCooldown = cooldown
    self.cooldown = 0
end

return Projectile
