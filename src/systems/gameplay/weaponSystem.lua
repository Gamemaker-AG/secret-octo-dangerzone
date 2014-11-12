local WeaponSystem = class("WeaponSystem", System)


function WeaponSystem:__init()
    for index, entity in pairs(self.targets) do
        local target
        local lowest = entity:get("Weapon").range
        local oldTarget = entity:get("Weapon").target
        local position = entity:get("Transformable").position
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
    end
end


function WeaponSystem:requires()
    return {"Weapon", "Transformable"}
end
