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
        local shield = entity:get("Shield")
        local position = entity:get("Transformable").position
        love.graphics.setColor(200, 100, 250, 50)
        if shield.hitpoints > 20 then love.graphics.circle("fill", position.x, position.y, 90, 8) end
        if shield.hitpoints > 100 then love.graphics.circle("fill", position.x, position.y, 100, 8) end
    end
end

function ShieldSystem:requires()
    return {"Shield", "Transformable"}
end

return ShieldSystem
