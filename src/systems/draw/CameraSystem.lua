local lume = require("lib/lume/lume")

local constants = require("constants")
local Vector = require("helper/Vector")

local CameraSystem = class("CameraSystem", System)

-- This is a system intended for a singleton camera, using multiple cameras for a game wouldn't make sense
function CameraSystem:draw()
    local pos = table.firstElement(self.targets):get("Transformable").position
    love.graphics.translate(-pos.x, -pos.y)
end

function CameraSystem:update()
    local transformable = table.firstElement(self.targets):get("Transformable")
    local camera = table.firstElement(self.targets):get("Camera")
    local targetPos = camera.target:get("Transformable").position:subtract(Vector(constants.screenWidth/2, constants.screenHeight/2))

    transformable.offset.x = lume.smooth(transformable.position.x, targetPos.x, constants.camera.speed)
    transformable.offset.y = lume.smooth(transformable.position.y, targetPos.y, constants.camera.speed)

end

function CameraSystem:requires()
    return {"Camera"}
end

return CameraSystem
