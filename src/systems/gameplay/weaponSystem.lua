local WeaponSystem = class("WeaponSystem", System)


function WeaponSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local target
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position

        local lowest = weapon.range
        local oldTarget = weapon.target
        if oldTarget ~= nil then
            for index, enemy in pairs(stack:current().engine:getEntityList("Enemy")) do
                local enemeyPosition = enemy:get("Transformable").position
                if lowest <= position:subtract(enemyPosition):length() then
                    local target = enemy
                end
            end
            if target then
                entity:get("Weapon").target = target
            end
        end
        target = entity:get("Weapon").target
        weapon.cooldown = weapon.cooldown - dt
        if target ~= nil then
            if weapon.cooldown <= 0 then
                weapon.cooldown = weapon.defaultCooldown
                weapon.fire()
            end
        end
    end
end


function WeaponSystem:requires()
    return {"Weapon", "Transformable"}
end

return WeaponSystem
