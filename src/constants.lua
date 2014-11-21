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
        defaultAcceleration = pixels(100),
        defaultRotationSpeed = math.pi*3/2,
        maxSpeed = pixels(60)
    },
    enemy = {
        diameter = pixels(4),
        defaultAcceleration = pixels(30),
        defaultRotationSpeed = math.pi,
    },
    bullet = {
        diameter = pixels(1),
        speed = pixels(100)
    },
    camera = {
        -- between 0 and 1
        speed = 0.5
    }
}

constants.enemy.maxSpeed = constants.player.maxSpeed / 5

return constants
