
local AccelerationSystem = class("AccelerationSystem", System)

function AccelerationSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local acc = entity:get("AccelerationComponent")
        local speed = entity:get("SpeedComponent")
        if acc.active == true then
            print("active")
            print(acc.acc*dt)
            speed.speed = speed.speed + acc.acc * dt
            print(speed.speed)
            if speed.speed > speed.maxSpeed then
                speed.speed = speed.maxSpeed
            end
        else
            speed.speed = speed.speed - 1/3 * acc.acc * dt
            if speed.speed < 0 then speed.speed = 0 end
        end
    end
end

function AccelerationSystem:requires()
    return {"AccelerationComponent"}
end

return AccelerationSystem
