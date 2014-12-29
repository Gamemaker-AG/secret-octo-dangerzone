local Hull = class("Hull", Component)

function Hull:__init(hitpoints)
    self.hitpoints = hitpoints
end

return Hull
