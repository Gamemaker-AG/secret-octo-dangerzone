local Drawable = require("components/graphic/Drawable")
local Transformable = require("components/physic/Transformable")
local Debris = require("components/gameplay/Debris")
local CircleShape = require("components/physic/Circle")
local SpaceStation = require("components/gameplay/SpaceStation")

return function(position)
	local components = {}

	local img = resources.images.space_station
	local ox, oy = img:getWidth()/2, img:getHeight()/2

	table.insert(components, Drawable(img, nil, nil, nil, ox, oy))
	table.insert(components, Transformable(position))
	table.insert(components, CircleShape(constants.spaceStation.diameter))
	table.insert(components, SpaceStation())
	table.insert(components, Debris())

	return components
end