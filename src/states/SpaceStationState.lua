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
	self.engine = Engine()
    self.engine:getRootEntity():add(Transformable())
	self.eventmanager = EventManager()

	self.eventmanager:addListener("KeyReleased", {}, function() stack:pop() end)

	-- Systems
	self.engine:addSystem(DrawSystem())
	self.engine:addSystem(TransformableUpdateSystem())
	self.engine:addSystem(TextDrawSystem())

	-- BG
	local uiBg = Entity()
	local img = resources.images.space_station_ui
	local sy = constants.screenHeight / img:getHeight()
	local sx = sy
	local ox = (constants.screenWidth - img:getWidth()*sx) / 2
	uiBg:add(Drawable(img, 0, sx, sy))
	uiBg:add(Transformable(Vector(ox, 0)))
	self.engine:addEntity(uiBg)

	-- Reposition Player
	self.oldPlayer = player
	player = Entity()
	local playerOffset = Vector(ox+280*sx, 240*sy)
	player:add(Transformable(playerOffset))
	player:add(Drawable(resources.images.player))
	player:add(Circle(percentToPixels(15)))
	player:add(self.oldPlayer:get("Inventory"))
	self.engine:addEntity(player)

	-- Display Inventory Items
	local itemRadius = (img:getWidth()/26)*sx
	local globalItemOffset = playerOffset:clone():add(Vector(600*sx, itemRadius))
	for index, item in pairs(player:get("Inventory").inventory) do
		local entity = Entity()
		entity:add(item:get("Drawable"))
		local gap = itemRadius*8/3
		local localOffset = Vector(gap * ((index-1) % 4), gap * math.floor((index-1)/4))
		entity:add(Transformable(globalItemOffset:add(localOffset)))
		entity:add(Circle(itemRadius))
		self.engine:addEntity(entity)
	end
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