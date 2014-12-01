local Destroyed = require("components/gameplay/Destroyed")

local DebrisDestroySystem = class("DebrisDestroySystem", System)

function DebrisDestroySystem:update(dt)
    for _, entity in pairs(self.targets) do
        -- local explodeComponent = entity:get("ExplodesOnContact")
        -- local targetPos = explodeComponent.target and explodeComponent.target:get("Transformable").position
        -- local target = explodeComponent.target
        -- if targetPos and targetPos:distanceTo(entity:get("Transformable").position) < explodeComponent.distance then
        --     if entity:has("Damaging") then
        --         if target:has("Living") then
        --             local living = target:get("Living")
        --             living.life = living.life - entity:get("Damaging").damage
        --             if living.life <= 0 then
        --                 target:add(Destroyed())
        --             end
        --         end
        --     end
        --     entity:add(Destroyed())
        -- end
    end
end

function DebrisDestroySystem:requires()
    return {"ExplodesOnContact", "Transformable"}
end

return DebrisDestroySystem
