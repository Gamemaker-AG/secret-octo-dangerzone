DrawableComponent = class("DrawableComponent", Component)

function DrawableComponent:__init(image, r, sx, sy, ox, oy)
    self.image = image
    self.sx = sx
    self.sy = sy
    self.ox = ox
    self.oy = oy
end

return DrawableComponent
