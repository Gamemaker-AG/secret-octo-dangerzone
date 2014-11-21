local Camera = class("Camera")

function Camera:__init(target)
    self.target = target
    self.position = target:get("Transformable").position:clone()
end

return Camera
