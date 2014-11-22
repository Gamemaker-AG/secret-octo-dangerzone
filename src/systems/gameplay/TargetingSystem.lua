local TargetingSystem = class("TargetingSystem", System)

function TargetingSystem:update()
    for index, entity in pairs(self.targets["moving"]) do
        local moving = entity:get("MovingTo")
        if moving.target == nil or not moving.target.alive then
            if entity:has("Weapon") then
                moving.target = entity:get("Weapon").target
            end
        end
    end

    for index, entity in pairs(self.targets["weapon"]) do
        local weapon = entity:get("Weapon")
        local position = entity:get("Transformable").position

        local lowest = weapon.range

        if weapon.target == nil or not weapon.target.alive then
            weapon.target = nil
            local list = stack:current().engine:getEntityList("Faction") 
            for index, enemy in pairs(list) do
                if entity:get("Faction").attitude[enemy:get("Faction").faction] then
                    local enemyPosition = enemy:get("Transformable").position
                    if position:distanceTo(enemyPosition) <= lowest then
                        lowest = position:distanceTo(enemyPosition)
                        weapon.target = enemy
                    end
                end
            end
        end
    end

    for index, entity in pairs(self.targets["looking"]) do
        local looking = entity:get("LookingAt")
        if looking.target == nil or not looking.target.alive then
            if entity:has("Weapon") then
                looking.target = entity:get("Weapon").target
            end
        end
    end
end

function TargetingSystem:requires()
    return {moving = {"MovingTo"}, looking={"LookingAt"}, weapon={"Weapon", "Faction"}}
end

return TargetingSystem
