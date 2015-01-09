local DrawableText = require("components/graphic/DrawableText")
local Transformable = require("components/physic/Transformable")
local DebugText = require("components/graphic/DebugText")

local Vector = require("helper/Vector")

local DebugSystem = class("DebugSystem", System)

function DebugSystem:__init()
    self.active = true
    self.fps = 0
    self.ups = 0
    self.updateCount = 0
    self.drawCount = 0
    self.time = 0
end

function DebugSystem:update(dt)
    self.updateCount = self.updateCount + 1
    self.time = self.time + dt
    if self.time > 1 then
        self.time = 0
        self.ups = self.updateCount
        self.updateCount = 0
        self.fps = self.drawCount
        self.drawCount = 0
    end
end

function DebugSystem:draw()
    self.drawCount = self.drawCount + 1
end

function DebugSystem:setInvisibility(event)
    if event.key == "h" then
        self.active = not self.active
        for _, entity in pairs(self.targets) do
            entity:get("DrawableText").visible = self.active
        end
    end
end

function DebugSystem:requires()
    return {"DebugText", "DrawableText"}
end

return DebugSystem
