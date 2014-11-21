local State = class("State")

State.renderBelow = false

function State:update(dt) end
function State:draw() end
function State:shutdown() end
function State:keypressed(key, isrepeat) end
function State:keyreleased(key, isrepeat) end
function State:mousepressed(x, y, key) end
function State:load() end

return State
