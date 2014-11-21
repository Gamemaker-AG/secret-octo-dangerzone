local MovingTo = class("MovingTo", Component)

function MovingTo:__init(target) 
    self.target = target
end

return MovingTo
