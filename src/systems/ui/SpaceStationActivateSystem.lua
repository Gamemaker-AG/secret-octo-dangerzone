local SpaceStationActivateSystem = class("SpaceStationActivateSystem", System)

function SpaceStationActivateSystem:keyPressed(event)
	if event.key == " " then
		local playerPos = table.firstElement(stack:current().engine:getEntitiesWithComponent("Player")):get("Transformable").position
		for i, station in pairs(self.targets) do
			if station:get("Transformable").position:distanceTo(playerPos) < 100 then
				print("hit a space station")
			end
		end
	end
end

function SpaceStationActivateSystem:requires()
	return {"SpaceStation"}
end

return SpaceStationActivateSystem