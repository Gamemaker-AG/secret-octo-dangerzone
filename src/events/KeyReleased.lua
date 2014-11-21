local KeyReleased = class("KeyReleased")

function KeyReleased:__init(key, isrepeat)
    self.key = key
    self.isrepeat = isrepeat
end

return KeyReleased
