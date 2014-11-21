local ExplodeOnContactSystem = class("ExplodeOnContactSystem", System)

function ExplodeOnContactSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local explodeComponent = entity:get("ExplodesOnContact")
        local targetPos = explodeComponent.target and explodeComponent.target:get("Transformable").position
        if targetPos and targetPos:distanceTo(entity:get("Transformable").position) < explodeComponent.distance then
            stack:current().engine:removeEntity(entity)
        end
    end
end

function ExplodeOnContactSystem:requires()
    return {"ExplodesOnContact", "Transformable"}
end

return ExplodeOnContactSystem
