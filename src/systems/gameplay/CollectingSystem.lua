local CollectingSystem = class("CollectingSystem", System)
local Destroyed = require("components/gameplay/Destroyed")

function CollectingSystem:update(dt)
    local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
    local playerPosition = player:get("Transformable").position
    for _, loot in pairs(self.targets) do
        local lootPosition = loot:get("Transformable").position
        local distance = playerPosition:distanceTo(lootPosition)
        if distance < player:get("Circle").radius then
            loot:set(Destroyed())
            local playergold = player:get("HasGold")
            playergold.gold = playergold.gold + loot:get("Collectible").gold
        end
    end
end

function CollectingSystem:requires()
    return {"Collectible"}
end

return CollectingSystem
