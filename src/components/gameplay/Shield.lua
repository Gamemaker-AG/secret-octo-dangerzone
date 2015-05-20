local Shield = Component.create("Shield")

function Shield:__init(max, restores)
    self.hitpoints = max
    self.restores = restores
    self.maxHitpoints = max
end

return Shield
