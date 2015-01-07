local DebugSystem = class("DebugSystem", System)

function DebugSystem:__init()
    self.active = true
end

function DebugSystem:setInvisibility(event)
    if event.key == "h" then
        self.active = not self.active
        for _, entity in pairs(self.targets) do
            entity:get("DrawableText").visible = self.active
        end
    end
end

function DebugSystem:requires()
    return {"DebugText", "DrawableText"}
end

return DebugSystem
