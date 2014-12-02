local ParallaxSystem = class("ParallaxSystem", System)
local Camera = require("components/gameplay/Camera")
local Vector = require("helper/Vector")

function ParallaxSystem:update(dt)
    for _, entity in pairs(self.targets) do
        local depth = entity:get("Parallax").depth
        local pos = entity:get("Transformable").position
        local cam = table.firstElement(stack:current().engine:getEntityList("Camera"))
        if cam then 
            pos:set(cam:get("Camera").position:multiply(1/depth))
        end
    end
end

function ParallaxSystem:requires()
    return {"Parallax", "Transformable"}
end

return ParallaxSystem