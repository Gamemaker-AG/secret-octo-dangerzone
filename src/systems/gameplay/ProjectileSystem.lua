local createProjectileCollection = require("collections/createProjectileCollection")

local ProjectileSystem = class("ProjectileSystem", System)

function ProjectileSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position
        local projectile = entity:get("ShootsProjectile")

        local lowest = weapon.range
        local target = weapon.target

        projectile.cooldown = projectile.cooldown - dt
        if target ~= nil then
            if projectile.cooldown <= 0 then
                projectile.cooldown = projectile.defaultCooldown
                projectile.volleyCount = projectile.shotsPerVolley
            end
            if projectile.volleyCount > 0 then
                projectile.waitCooldown = projectile.waitCooldown - dt
                if projectile.waitCooldown < 0 then
                    projectile.volleyCount = projectile.volleyCount - 1
                    for i=0, projectile.simultaneousShots , 1 do
                        stack:current().engine:addEntity(createProjectileCollection(Entity(), position, target, projectile.damage, projectile.precision))
                    end
                    projectile.waitCooldown = projectile.waitTime
                    projectile.volleyCount = projectile.volleyCount - projectile.simultaneousShots
                end
            end
        end
    end
end


function ProjectileSystem:requires()
    return {"Weapon", "ShootsProjectile", "Transformable"}
end

return ProjectileSystem
