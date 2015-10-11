local MouseReleased = class("MouseReleased")

function MouseReleased:initialize(x, y, button)
    self.button = button
    self.y = y
    self.x = x
end

return MouseReleased
