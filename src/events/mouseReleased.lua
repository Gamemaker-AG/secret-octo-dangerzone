local MouseReleased = class("MouseReleased")

function MouseReleased:__init(x, y, button)
    self.button = button
    self.y = y
    self.x = x
end

return MouseReleased
