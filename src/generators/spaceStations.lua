local createSpaceStationCollection = require("collections/createSpaceStationCollection")

return function(position, size)
	math.randomseed(position.x * position.y)
	if math.random(0, 100) <= 1 then
		local station = Entity()
		station:addMultiple(createSpaceStationCollection(position))
		stack:current().engine:addEntity(station)
		return station
	end
	return nil
end