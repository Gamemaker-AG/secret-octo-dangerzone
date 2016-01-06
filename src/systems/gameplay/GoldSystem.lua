local MovingTo, Transformable, Drawable, Accelerating, Moving, Collectible = Component.load({"MovingTo", "Transformable", "Drawable", "Accelerating", "Moving", "Collectible"})

local GoldSystem = class("GoldSystem", System)

function GoldSystem:addGold(event)
    local enemy = event.enemy
	local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))

	local loot = Entity()
	loot:add(Transformable(enemy:get("Transformable").offset:clone()))
	loot:add(Drawable(resources.images.circle, 0, 0.1, 0.1))
	loot:add(Accelerating(constants.collectible.defaultAcceleration, Vector()))
	loot:add(Moving(Vector(), constants.collectible.maxSpeed))
	loot:add(MovingTo(player))
    local drop = enemy:get("HasLoot")
    loot:add(Collectible(drop.gold, drop.item))
	stack:current().engine:addEntity(loot)
end

function GoldSystem:requires()
	return {"HasGold"}
end

return GoldSystem
