local KeyReleased = class("KeyReleased")

function KeyReleased:initialize(key, isrepeat)
    self.key = key
    self.isrepeat = isrepeat
end

return KeyReleased
