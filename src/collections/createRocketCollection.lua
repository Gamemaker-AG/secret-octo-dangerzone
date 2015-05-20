-- Core
local Vector = require("helper/Vector")

-- Graphic components
local Drawable = require("components/graphic/Drawable")
local Particle = require("components/particle/Particle")
local Muzzleparticles = require("components/graphic/Muzzleparticles")

-- Physic components
local Moving = require("components/physic/Moving")
local Damaging = require("components/gameplay/Damaging")
local Transformable = require("components/physic/Transformable")
local ExplodesOnContact = require("components/gameplay/ExplodesOnContact")
local Circle = require("components/physic/Circle")

-- Gameplay components
local Debris = require("components/gameplay/Debris")


function createRocketCollection(entity, pos, target, damage)
    local components = {}

    -- Physical components
    table.insert(components, Debris(target, 100))

    local transformable = entity:get("Transformable")
    table.insert(components, Transformable(pos:clone()))

    -- Calculate direction to target and set it
    local direction = target:get("Transformable").position:subtract(pos):getUnit()
    transformable.direction:set(direction)

    -- Set rocket speed vector
    table.insert(components, Moving(direction:multiply(constants.rocket.speed)))
    table.insert(components, Circle(constants.rocket.diameter))

    -- Meta components
    table.insert(components, Damaging(damage))
    table.insert(components, ExplodesOnContact(target))

    -- Graphic components
    table.insert(components, Muzzleparticles(100 ,100*constants.rocket.traillength, 500, 3000))
        -- Getting Stuff for image
    local image = resources.images.rocket
    local ox, oy = image:getWidth()/2, image:getHeight()/2
    table.insert(components, Drawable(image, 1, sx, sy, ox, oy))

    -- Particle component
    local particleComponent = Particle(resources.images.particle1, 5000, Vector(-10, 0), {0.2, 1.2}, nil)
    table.insert(components, particleComponent)

    -- Set locals for particle
    local particle = particleComponent.particle
    local radian = transformable.direction:getRadian()
    -- Calculate stuff for particle
    local rotatedOffset = particleComponent.offset:rotate(transformable.direction:getRadian()):add(transformable.position)

    -- Particle properties
    particle:setPosition(rotatedOffset.x, rotatedOffset.y)
    particle:setEmissionRate(1000)
    particle:setAreaSpread("normal",3,3)
    particle:setSpread(math.pi/40)
    particle:setParticleLifetime(0.01, 0.1)
    particle:setColors(--250,160,30,20,  --orange
                       --240,80,35,50,  --redish orange
                        --240,35,40,50,  --red
                        216,30,60,50, --greeeenish
                        --255,255,255,50, --white
                        200,0,255,50, --blueish purple
                        70,0,92,50, --dark purple
                        --0,0,0,100, --black
                        --255,255,255,20, --white
                        --20,20,150,50,  --blue
                        --2,125,200,50,  --light blue
                        --0,170,185,50,  --greenish blue
                        0,0,0,100 --black
                        --0,166,84,50   --light green
                        )    --light green
    particle:setSizes(1.5, 0.8, 0.1)
    particle:start()

    return components
end

return createRocketCollection
