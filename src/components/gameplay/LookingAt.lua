local LookingAt = class("LookingAt", Component)

function LookingAt:__init(target)
    self.target = target or nil
end

return LookingAt
