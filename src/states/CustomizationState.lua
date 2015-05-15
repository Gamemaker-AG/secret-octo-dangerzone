local DrawSystem = require("systems/draw/DrawSystem")
local StringDrawSystem = require("systems/draw/StringDrawSystem")
local TransformableUpdateSystem = require("systems/physic/TransformableUpdateSystem")
local ClickableSystem = require("systems/ui/ClickableSystem")

local KeyPressed = require("events/KeyPressed")
local KeyReleased = require("events/KeyReleased")

local State = require("core/State")
local CustomizationState = class("CustomizationState", State)

Component.load({
	"Drawable",
	"Transformable"
})

function CustomizationState:__init(player)
	player = player
end

function CustomizationState:load()
	self.engine = Engine()
	self.eventmanager = EventManager()

	self.eventmanager:addListener("KeyReleased", {}, function() stack:pop() end)

	self.engine:addSystem(DrawSystem())

	local uiBg = Entity()
	uiBg:add(Drawable(resources.images.customization_ui))
	uiBg:add(Transformable())
end

function CustomizationState:update(dt)
	self.engine:update(dt)
end

function CustomizationState:draw()
	self.engine:draw()
end

return CustomizationState