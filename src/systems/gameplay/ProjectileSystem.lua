local createProjectileCollection = require("collections/createProjectileCollection")

local ProjectileSystem = class("ProjectileSystem", System)

function ProjectileSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position
        local projectile = entity:get("Projectile")

        local lowest = weapon.range
        local target = weapon.target

        projectile.cooldown = projectile.cooldown - dt
        if target ~= nil then
            if projectile.cooldown <= 0 then
                projectile.cooldown = projectile.defaultCooldown
                for i=0, projectile.bulletAmount, 1 do
                    stack:current().engine:addEntity(createProjectileCollection(Entity(), position, target, projectile.damage, projectile.precision))
                end
            end
        end
    end
end


function ProjectileSystem:requires()
    return {"Weapon", "Projectile", "Transformable"}
end

return ProjectileSystem
