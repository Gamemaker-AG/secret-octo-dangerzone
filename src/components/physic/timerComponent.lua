TimerComponent = class("TimerSystem")

function TimerComponent:__init(event, time)
    self.time = time
    self.event = event
end
