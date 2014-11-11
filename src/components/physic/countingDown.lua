local CountingDown = class("TimerSystem", Component)

function CountingDown:__init(event, time)
    self.time = time
    self.event = event
end

return CountingDown
