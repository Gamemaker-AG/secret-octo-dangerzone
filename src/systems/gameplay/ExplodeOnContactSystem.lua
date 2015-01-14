local Destroyed = require("components/gameplay/Destroyed")
local DamageDone = require("events/DamageDone")

local ExplodeOnContactSystem = class("ExplodeOnContactSystem", System)

function ExplodeOnContactSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local explodeComponent = entity:get("ExplodesOnContact")
        local target = explodeComponent.target
        local targetPos = target and target:get("Transformable").position
        local targetRadius = (target:get("Circle") and target:get("Circle").radius) or 0

        if targetPos and targetPos:distanceTo(entity:get("Transformable").position) < targetRadius + explodeComponent.distance then
            if entity:has("Damaging") then
                stack:current().eventmanager:fireEvent(DamageDone(entity:get("Damaging").damage, target))
            end
            entity:add(Destroyed())
        end
    end
end

function ExplodeOnContactSystem:requires()
    return {"ExplodesOnContact", "Transformable", "Circle"}
end

return ExplodeOnContactSystem
