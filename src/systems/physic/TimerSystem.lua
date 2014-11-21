local TimerSystem = class("TimerSystem", System)

function TimerSystem:update(dt)
    for index, entity in pairs(self.targets) do
        if entity:get("CountingDown").time <= 0 then
            stack:current().eventmanager:fireEvent(entity:get("CountingDown").event)
        else
            entity:get("CountingDown").time = entity:get("CountingDown").time - dt
        end
    end
end

function TimerSystem:requires()
    return {"CountingDown"}
end

return TimerSystem
