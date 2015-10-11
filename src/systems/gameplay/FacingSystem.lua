local FacingSystem = class("FacingSystem", System)

function FacingSystem:initialize()
    self.sortedTargets = {}
end

function FacingSystem:update()
    for index, entity in pairs(self.targets) do
        local transformable = entity:get("Transformable")
        if entity:get("LookingAt").target then
            local targetPosition = entity:get("LookingAt").target:get("Transformable").position
            entity:get("Transformable").direction:set(transformable.position:subtract(targetPosition):getUnit():multiply(-1))
        end
    end
end

function FacingSystem:requires()
    return {"LookingAt"}
end

return FacingSystem
