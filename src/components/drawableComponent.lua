DrawableComponent = class("DrawableComponent")

function DrawableComponent:__init(image, r, sx, sy, ox, oy)
    self.image = image
    self.r = r
    if sx then self.sx = sx else self.sx = 1 end
    if sy then self.sy = sy else self.sy = 1 end
    if ox then self.ox = ox else self.ox = 1 end
    if oy then self.oy = oy else self.oy = 1 end
end