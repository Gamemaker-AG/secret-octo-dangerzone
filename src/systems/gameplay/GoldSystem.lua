local GoldSystem = class("GoldSystem", System)


function GoldSystem:update(dt)
local loot = 0
	print(table.count(self.targets.players))
		print(table.count(self.targets.enemies))
	for key, entity in pairs(self.targets.enemies) do
		if entity:has("Destroyed") then
			local amount = entity:get("DropsGold").gold
			loot = loot + amount
		end
	end
	for key, entity in pairs(self.targets.players) do
		local playergold = entity:get("HasGold")
		playergold.gold = playergold.gold + loot 
	end
end

function GoldSystem:requires()
	return {players = {"HasGold"}, enemies = {"DropsGold"}}
end

return GoldSystem