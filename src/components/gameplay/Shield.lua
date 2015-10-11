local Shield = Component.create("Shield")

function Shield:initialize(max, restores)
    self.hitpoints = max
    self.restores = restores
    self.maxHitpoints = max
end

return Shield
