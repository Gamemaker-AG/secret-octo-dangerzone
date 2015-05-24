local DrawSystem = require("systems/draw/DrawSystem")
local TextDrawSystem = require("systems/draw/TextDrawSystem")
local TransformableUpdateSystem = require("systems/physic/TransformableUpdateSystem")
local ClickableSystem = require("systems/ui/ClickableSystem")

local KeyPressed = require("events/KeyPressed")
local KeyReleased = require("events/KeyReleased")

local State = require("core/State")
local SpaceStationState = class("SpaceStationState", State)

Component.load({
	"Drawable",
	"Transformable",
	"Circle"
})

function SpaceStationState:__init()
end

function SpaceStationState:load()
	self.oldPlayer = player
	player = Entity()

	self.engine = Engine()
    self.engine:getRootEntity():add(Transformable())
	self.eventmanager = EventManager()

	self.eventmanager:addListener("KeyReleased", {}, function() stack:pop() end)

	self.engine:addSystem(DrawSystem())
	self.engine:addSystem(TransformableUpdateSystem())
	self.engine:addSystem(TextDrawSystem())

	local uiBg = Entity()
	local img = resources.images.space_station_ui
	local sy = constants.screenHeight / img:getHeight()
	local sx = sy
	local ox = (constants.screenWidth - img:getWidth()*sx) / 2
	uiBg:add(Drawable(img, 0, sx, sy))
	uiBg:add(Transformable(Vector(ox, 0)))
	self.engine:addEntity(uiBg)

	player:add(Transformable(Vector(ox+280*sx, 240*sy)))
	player:add(Drawable(resources.images.player))	
	player:add(Circle(percentToPixels(15)))
	self.engine:addEntity(player)
end

function SpaceStationState:pop()
	player = self.oldPlayer
end

function SpaceStationState:update(dt)
	self.engine:update(dt)
end

function SpaceStationState:draw()
	self.engine:draw()
end

return SpaceStationState