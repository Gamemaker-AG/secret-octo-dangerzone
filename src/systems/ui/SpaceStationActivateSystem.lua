local Transformable = require("components/physic/Transformable")

local SpaceStationActivateSystem = class("SpaceStationActivateSystem", System)

function SpaceStationActivateSystem:getCollidingStation()
	local player = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player"))
	local playerPos = player:get("Transformable").position
	for _, station in pairs(self.targets) do
		if station:get("Transformable").position:distanceTo(playerPos)- < 0 then
			return station
		end
	end
end

function SpaceStationActivateSystem:keyPressed(event)
	if event.key == " " and self:getCollidingStation() then
		print("docking process starting!")
	end
end

function SpaceStationActivateSystem:update()
	local collidingStation = self:getCollidingStation()
	if collidingStation then
		if not self.hoverText then
			self.hoverText = Entity(collidingStation)	
			self.hoverText:add(Transformable())
		end
	elseif self.hoverText then
		stack:current().engine:removeEntity(self.hoverText)
		self.hoverText = nil
	end
end

function SpaceStationActivateSystem:requires()
	return {"SpaceStation"}
end

return SpaceStationActivateSystem