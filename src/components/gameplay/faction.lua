local Faction = class("Faction")

function Faction:__init(faction, attitude)
    self.faction = faction
    self.attitude = attitude
end

return Faction
