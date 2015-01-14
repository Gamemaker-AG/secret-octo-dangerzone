local Rectangle = class("Rectangle")

function Rectangle:__init(width, height)
    self.width = width or 0
    self.height = height or 0
end

return Rectangle
