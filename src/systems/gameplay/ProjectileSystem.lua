local createProjectileCollection = require("collections/createProjectileCollection")

local ProjectileSystem = class("ProjectileSystem", System)

function ProjectileSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position
        local shootsProjectile = entity:get("ShootsProjectile")

        local lowest = weapon.range
        local target = weapon.target

        shootsProjectile.cooldown = shootsProjectile.cooldown - dt
        if target ~= nil then
            if shootsProjectile.cooldown <= 0 then
                shootsProjectile.cooldown = shootsProjectile.defaultCooldown
                shootsProjectile.volleyCount = shootsProjectile.shotsPerVolley
            end
            if shootsProjectile.volleyCount > 0 then
                shootsProjectile.waitCooldown = shootsProjectile.waitCooldown - dt
                if shootsProjectile.waitCooldown < 0 then
                    for i=0, shootsProjectile.simultaneousShots , 1 do
                        local projectile = Entity()
                        projectile:addMultiple(
                            createProjectileCollection(position, target, shootsProjectile.damage, shootsProjectile.precision)
                        )
                        stack:current().engine:addEntity(projectile)
                    end
                    shootsProjectile.waitCooldown = shootsProjectile.waitTime
                    shootsProjectile.volleyCount = shootsProjectile.volleyCount - shootsProjectile.simultaneousShots
                end
            end
        end
    end
end


function ProjectileSystem:requires()
    return {"Weapon", "ShootsProjectile", "Transformable"}
end

return ProjectileSystem
