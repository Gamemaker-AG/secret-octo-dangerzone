local Transformable = require("components/physic/Transformable")
local Drawable = require("components/graphic/Drawable")
local Circle = require("components/physic/Circle")
local Debris = require("components/gameplay/Debris")

return function(position, size)
	local star = Entity()
	star:add(Transformable(position:clone():add(size/2)))
	star:add(Drawable(resources.images.circle))
	star:add(Circle(percentToPixels(1)))
	star:add(Debris())
	stack:current().engine:addEntity(star)
	return star
end