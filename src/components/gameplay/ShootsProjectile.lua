local ShootsProjectile = Component.create("ShootsProjectile")

function ShootsProjectile:__init(damage, cooldown, precision, shotsPerVolley, volleyTime, waitTime)
    self.damage = damage
    self.precision = precision or 0
    self.shotsPerVolley = shotsPerVolley or 1
    self.defaultCooldown = cooldown
    self.simultaneousShots = (waitTime) and math.ceil(shotsPerVolley/(volleyTime/waitTime)) or 1
    self.waitTime= waitTime or (volleyTime/shotsPerVolley)

    -- These are runner
    self.bulletsLeft = 0
    self.cooldown = 0
    self.waitCooldown = 0
end

return ShootsProjectile
