local Destroyed = require("components/gameplay/Destroyed")
local DamageDone = require("events/DamageDone")

local ExplodeOnContactSystem = class("ExplodeOnContactSystem", System)

function ExplodeOnContactSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local explodeComponent = entity:get("ExplodesOnContact")
        local targetPos = explodeComponent.target and explodeComponent.target:get("Transformable").position
        local target = explodeComponent.target
        if targetPos and targetPos:distanceTo(entity:get("Transformable").position) < explodeComponent.distance then
            if entity:has("Damaging") then
                stack:current().eventmanager:fireEvent(DamageDone(entity:get("Damaging").damage, target))
            end
            entity:add(Destroyed())
        end
    end
end

function ExplodeOnContactSystem:requires()
    return {"ExplodesOnContact", "Transformable"}
end

return ExplodeOnContactSystem
