local TargetMoveSystem = class("TargetMoveSystem", System)

function TargetMoveSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local target = entity:get("MovingTo").target
        if target then
            local targetPosition = target:get("Transformable").position
            local direction = targetPosition:subtract(entity:get("Transformable").position):getUnit()
            local accelerating = entity:get("Accelerating")
            accelerating.acceleration:set(direction:multiply(accelerating.defaultAcceleration))
        end
    end 
end

function TargetMoveSystem:requires()
    return {"MovingTo", "Transformable"}
end

return TargetMoveSystem
