Clickable = class("Clickable")

function Clickable:__init(clicked)
    self.clicked = clicked or function() end
end

return Clickable
