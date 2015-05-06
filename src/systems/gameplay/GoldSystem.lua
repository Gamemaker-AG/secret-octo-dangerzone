local Transformable = require("components/physic/Transformable")
local MovingTo = require("components/gameplay/MovingTo")
local Accelerating = require("components/physic/Accelerating")
local Moving = require("components/physic/Moving")
local GoldSystem = class("GoldSystem", System)

function GoldSystem:addGold(event)
    local enemy = event.enemy
	local amount = enemy:get("DropsGold").gold
	local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
	local playergold = player:get("HasGold")
	playergold.gold = playergold.gold + amount

	local loot = Entity()
	loot:add(Transformable(enemy:get("Transformable").offset:clone()))
	loot:add(Drawable(resources.images.circle, 0, 0.3, 0.3))
	loot:add(Accelerating(40))
	loot:add(Moving(nil, 100))
	loot:add(MovingTo(player))
	stack:current().engine:addEntity(loot)
end

function GoldSystem:requires()
	return {"HasGold"}
end

return GoldSystem
