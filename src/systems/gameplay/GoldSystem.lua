Component.load({"Transformable", "Drawable"})

local GoldSystem = class("GoldSystem", System)

function GoldSystem:addGold(event)
    local enemy = event.enemy
	local amount = enemy:get("DropsGold").gold
	local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
	local playergold = player:get("HasGold")
	playergold.gold = playergold.gold + amount

	local loot = Entity()
	loot:add(Transformable(enemy:get("Transformable").offset:clone()))
	loot:add(Drawable(resources.images.circle))
	stack:current().engine:addEntity(loot)
end

function GoldSystem:requires()
	return {"HasGold"}
end

return GoldSystem
