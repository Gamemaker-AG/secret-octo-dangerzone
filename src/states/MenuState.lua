local GameState = require("states/GameState")

local KeyPressed = require("events/KeyPressed")

local DrawableText = require("components/graphic/DrawableText")
local Circle = require("components/physic/Circle")
local Transformable = require("components/physic/Transformable")
local Clickable = require("components/ui/Clickable")

local TextDrawSystem = require("systems/draw/TextDrawSystem")
local ClickableSystem = require("systems/ui/ClickableSystem")
local TransformableUpdateSystem = require("systems/physic/TransformableUpdateSystem")

local Vector = require("helper/Vector")

-- State superclass
local State = require("core/State")
local MenuState = class("MenuState", State)

function MenuState:load()
    self.engine = Engine()
    self.eventmanager = EventManager()
    self.engine:getRootEntity():add(Transformable())

    self.eventmanager:addListener("KeyPressed", {self, function(key, isrepeat)
        -- Start the game when any key is pressed
        stack:push(GameState())
    end})

    self.engine:addSystem(TextDrawSystem())
    self.engine:addSystem(TransformableUpdateSystem())

    local clickableSystem = ClickableSystem()
    self.engine:addSystem(clickableSystem)
    self.eventmanager:addListener("MouseReleased", clickableSystem, clickableSystem.mouseReleased)

    local startButton = Entity()
    startButton:add(DrawableText(resources.fonts.regular40, nil, "Start Game"))
    startButton:add(Circle(percentToPixels(40)))
    startButton:add(Transformable(Vector(percentToPixels(45))))
    startButton:add(Clickable(function() stack:push(GameState()) end))

    self.engine:addEntity(startButton)
end

function MenuState:update(dt)
    self.engine:update(dt)
end

function MenuState:draw()
    self.engine:draw()
end

return MenuState
