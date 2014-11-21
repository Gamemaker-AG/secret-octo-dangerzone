local lume = require("lib/lume/lume")

local constants = require("constants")
local Vector = require("helper/Vector")

local CameraSystem = class("CameraSystem", System)

-- This is a system intended for a singleton camera, using multiple cameras for a game would'nt make sense
function CameraSystem:draw()
    local pos = table.firstElement(self.targets):get("Camera").position
    love.graphics.translate(-pos.x, -pos.y)
end

function CameraSystem:update()
    local cam = table.firstElement(self.targets):get("Camera")
    local targetPos = cam.target:get("Transformable").position:subtract(Vector(constants.screenWidth/2, constants.screenHeight/2))

    cam.position.x = lume.lerp(cam.position.x, targetPos.x, constants.camera.speed)
    cam.position.y = lume.lerp(cam.position.y, targetPos.y, constants.camera.speed)
end

function CameraSystem:requires()
    return {"Camera"}
end

return CameraSystem
