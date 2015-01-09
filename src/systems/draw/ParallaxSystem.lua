local ParallaxSystem = class("ParallaxSystem", System)
local Camera = require("components/gameplay/Camera")
local Vector = require("helper/Vector")

function ParallaxSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local depth = entity:get("Parallax").depth
        local offset = entity:get("Transformable").offset
        local cam = table.firstElement(stack:current().engine:getEntitiesWithComponent("Camera"))
        if cam then 
            offset:set(cam:get("Transformable").position:multiply(1/depth))
        end
    end
end

function ParallaxSystem:requires()
    return {"Parallax", "Transformable"}
end

return ParallaxSystem
