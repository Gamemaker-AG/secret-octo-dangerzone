local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
local smallerDimension = sw < sh and sw or sh


local function pixels(percent)
    return percent * smallerDimension/100
end

local constants = {
    screenWidth = sw,
    screenHeight = sh,
    player = {
        diameter = pixels(20),
        defaultAcceleration = pixels(130),
        defaultRotationSpeed = math.pi*3/2,
        maxSpeed = pixels(50)
    },
    enemy = {
        diameter = pixels(5),
        defaultAcceleration = pixels(30),
        defaultRotationSpeed = math.pi,
    }
}

constants.enemy.maxSpeed = constants.player.maxSpeed / 5

return constants
