local Destroyed = require("components/gameplay/Destroyed")

local DebrisDestroySystem = class("DebrisDestroySystem", System)

function DebrisDestroySystem:update(dt)
    for _, entity in pairs(self.targets) do
        local debrisComponent = entity:get("Debris")
        local targetPos = debrisComponent.target and debrisComponent.target:get("Transformable").position
        local target = debrisComponent.target
        if targetPos and targetPos:distanceTo(entity:get("Transformable").position) > constants.gameplay.debrisMaxDistance then
            entity:add(Destroyed())
        end
    end
end

function DebrisDestroySystem:requires()
    return {"Debris", "Transformable"}
end

return DebrisDestroySystem
