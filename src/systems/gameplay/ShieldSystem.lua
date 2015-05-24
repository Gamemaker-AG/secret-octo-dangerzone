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
        local shieldPercentage = 100*shield.hitpoints/shield.maxHitpoints
        local maxAlpha = 40
        local minAlpha = 40
        local shieldSize = constants.player.diameter*2/3
        local shieldStep = 10
        if (shieldPercentage/100)*maxAlpha < minAlpha then alpha = minAlpha
        else alpha = (shieldPercentage/100)*maxAlpha
        end
        love.graphics.setColor(200, 100, 250, alpha)
        if shieldPercentage > 0 then love.graphics.circle("fill", position.x, position.y, shieldSize, 8) end
        love.graphics.setColor(200, 100, 250, 2*alpha)
        if shieldPercentage > 0 then love.graphics.circle("line", position.x, position.y, shieldSize, 8) end
        love.graphics.setColor(200, 100, 250, 5*alpha/6)
        if shieldPercentage > 20 then love.graphics.circle("fill", position.x, position.y, shieldSize+shieldStep, 8) end
        love.graphics.setColor(200, 100, 250, 4*alpha/6)
        if shieldPercentage > 40 then love.graphics.circle("fill", position.x, position.y, shieldSize+shieldStep*2, 8) end
        love.graphics.setColor(200, 100, 250, 3*alpha/6)
        if shieldPercentage > 60 then love.graphics.circle("fill", position.x, position.y, shieldSize+shieldStep*3, 8) end
        love.graphics.setColor(200, 100, 250, 2*alpha/6)
        if shieldPercentage > 80 then love.graphics.circle("fill", position.x, position.y, shieldSize+shieldStep*4, 8) end

    end
end

function ShieldSystem:requires()
    return {"Shield", "Transformable"}
end

return ShieldSystem
