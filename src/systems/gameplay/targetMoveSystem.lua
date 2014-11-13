local TargetMoveSystem = class("TargetMoveSystem", System)

function TargetMoveSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local targetPosition = entity:get("MovingTo").target:get("Transformable").position
        local direction = targetPosition:subtract(entity:get("Transformable").position):getUnit()
        if targetPosition then
            local accelerating = entity:get("Accelerating")
            accelerating.acceleration:set(direction:multiply(accelerating.defaultAcceleration))
        end
    end 
end

function TargetMoveSystem:requires()
    return {"MovingTo", "Transformable"}
end

return TargetMoveSystem
