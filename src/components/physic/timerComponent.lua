local TimerComponent = class("TimerSystem", Component)

function TimerComponent:__init(event, time)
    self.time = time
    self.event = event
end

return TimerComponent
