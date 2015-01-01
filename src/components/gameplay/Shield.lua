local Shield = class("Shield", Component)

function Shield:__init(hp, restores, max)
    self.hitpoints = hp
    self.restores = restores
    self.maxHitpoints = max
end

return Shield
