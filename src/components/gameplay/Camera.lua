local Camera = class("Camera", Component)

function Camera:__init(target)
    self.target = target
end

return Camera
