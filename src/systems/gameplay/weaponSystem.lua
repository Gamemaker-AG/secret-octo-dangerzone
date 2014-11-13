local WeaponSystem = class("WeaponSystem", System)


function WeaponSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position

        local lowest = weapon.range
        local target = weapon.target

        if target == nil then
            local list
            if entity:has("Controllable") then
                list = stack:current().engine:getEntityList("Enemy") 
            else
                list = stack:current().engine:getEntityList("Controllable") 
            end
            for index, enemy in pairs(list) do
                local enemyPosition = enemy:get("Transformable").position
                if position:subtract(enemyPosition):length() <= lowest then
                    target = enemy
                end
            end
            -- Setting target if existing
            if target then
                -- Setting target for weapon
                entity:get("Weapon").target = target
                if entity:has("LookingAt") then
                    -- Setting target for direction
                    entity:get("LookingAt").target = target
                end
            end
        end
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
