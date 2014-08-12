DrawableComponent = class("DrawableComponent")

function DrawableComponent:__init(image, r, width, height, ox, oy)
    self.image = image
    self.r = r or 0
    self.width = width or image:getWidth()
    self.height = height or image:getHeight()
    if ox then self.ox = ox else self.ox = 1 end
    if oy then self.oy = oy else self.oy = 1 end
end
