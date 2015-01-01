local ShieldSystem = class("ShieldSystem", System)

function ShieldSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local shield = entity:get("Shield")
        shield.hitpoints = shield.hitpoints + (shield.restores*dt)
        if shield.hitpoints > shield.maxHitpoints then shield.hitpoints = shield.maxHitpoints end
    end
end

function ShieldSystem:draw()
    for _, entity in pairs(self.targets) do
        local transformable = entity:get("Transformable")
        love.graphics.drawCircle()
    end
end

function ShieldSystem:requires()
    return {"Shield", "Transformable"}
end
