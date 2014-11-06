local TimerSystem = class("TimerSystem", System)

function TimerSystem:update(dt)
    for index, entity in pairs(self.targets) do
        if entity:get("TimerComponent").time <= 0 then
            stack:current().eventmanager:fireEvent(entity:get("TimerComponent").event)
        else
            entity:get("TimerComponent").time = entity:get("TimerComponent").time - dt
        end
    end
end

function TimerSystem:requires()
    return {"TimerComponent"}
end

return TimerSystem
