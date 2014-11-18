local TargetingSystem = class("TargetingSystem", System)

function TargetingSystem:update()
    for index, entity in pairs(self.targets["moving"]) do
        if entity:get("MovingTo").target == nil then
            if entity:has("Weapon") then
                entity:get("MovingTo").target = entity:get("Weapon").target
            end
        end
    end

    for index, entity in pairs(self.targets["weapon"]) do
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position

        local lowest = weapon.range
        local target = weapon.target

        if target == nil then
            local list = stack:current().engine:getEntityList("Faction") 
            for index, enemy in pairs(list) do
                if entity:get("Faction").attitude[enemy:get("Faction").faction] then
                    local enemyPosition = enemy:get("Transformable").position
                    if position:subtract(enemyPosition):length() <= lowest then
                        lowest = position:subtract(enemyPosition):length()
                        target = enemy
                    end
                end
            end
            -- Setting target if existing
            if target then
                -- Setting target for weapon
                entity:get("Weapon").target = target
            end
        end
    end

    for index, entity in pairs(self.targets["looking"]) do
        if entity:get("LookingAt").target == nil then
            if entity:has("Weapon") then
                entity:get("LookingAt").target = entity:get("Weapon").target
            end
        end
    end
end

function TargetingSystem:requires()
    return {moving = {"MovingTo"}, looking={"LookingAt"}, weapon={"Weapon", "Faction"}}
end

return TargetingSystem
