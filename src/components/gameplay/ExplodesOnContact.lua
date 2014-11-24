local ExplodesOnContact = class("ExplodesOnContact", Component)

function ExplodesOnContact:__init(target, distance)
    self.target = target
    self.distance = distance
end

return ExplodesOnContact
