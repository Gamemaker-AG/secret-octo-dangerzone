local Weapon = class("Weapon", Component)

function Weapon:__init(range, target) 
    self.target = target or nil
    self.range = range
end

return Weapon
