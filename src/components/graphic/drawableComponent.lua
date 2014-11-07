DrawableComponent = class("DrawableComponent", Component)

function DrawableComponent:__init(image, r, sx, sy, ox, oy)
    self.image = image
    self.r = r
end

return DrawableComponent
