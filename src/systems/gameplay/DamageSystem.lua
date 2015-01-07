local Destroyed = require("components/gameplay/Destroyed")

local DamageSystem = class("DamageSystem", System)

function DamageSystem:fireEvent(event)
    local target = event.target
    local damage = event.damage  
    local shield
    if target:get("Shield") then shield = target:get("Shield") end
    local hull = target:get("Hull")

    if shield ~= nil and shield.hitpoints > 0 then
        shield.hitpoints = shield.hitpoints - damage
        if shield.hitpoints < 0 then
            damage = math.abs(shield.hitpoints)
            shield.hitpoints = 0
        else
            damage = 0
        end
    end
    if damage > 0 then
        hull.hitpoints = hull.hitpoints - damage
        if hull.hitpoints <= 0 then
            target:set(Destroyed())
        end
    end
end

return DamageSystem
