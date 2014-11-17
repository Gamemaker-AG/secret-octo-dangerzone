local WeaponSystem = class("WeaponSystem", System)


function WeaponSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position

        local lowest = weapon.range
        local target = weapon.target

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
