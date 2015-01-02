local GoldSystem = class("GoldSystem", System)


function GoldSystem:addGold(event)
    local enemy = event.enemy
	local amount = enemy:get("DropsGold").gold
	for _, entity in pairs(self.targets) do
		local playergold = entity:get("HasGold")
		playergold.gold = playergold.gold + amount
	end
end

function GoldSystem:requires()
	return {"HasGold"}
end

return GoldSystem
