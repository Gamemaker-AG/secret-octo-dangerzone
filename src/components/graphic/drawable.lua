Drawable = class("Drawable", Component)

function Drawable:__init(image, index, sx, sy, ox, oy)
    self.image = image
    self.index = index
    self.sx = sx
    self.sy = sy
    self.ox = ox
    self.oy = oy
end

return Drawable
