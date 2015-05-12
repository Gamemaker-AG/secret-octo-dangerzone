local Drawable = require("components/graphic/Drawable")
local Transformable = require("components/physic/Transformable")
local Debris = require("components/gameplay/Debris")
local CircleShape = require("components/physic/Circle")
local SpaceStation = require("components/gameplay/SpaceStation")

return function(position)
	local components = {}

	table.insert(components, Drawable(resources.images.space_station))
	table.insert(components, Transformable(position))
	table.insert(components, CircleShape(percentToPixels(10)))
	table.insert(components, SpaceStation())
	table.insert(components, Debris())

	return components
end