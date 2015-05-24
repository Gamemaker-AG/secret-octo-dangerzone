-- Core
local Vector = require("helper/Vector")
local createTurretCollection = require("collections/createTurretCollection")

Component.load({
    -- Graphic components
    "Drawable",
    "Particle",
    "Muzzleparticles",

    -- Physic components
    "Moving",
    "Rotating",
    "Accelerating",
    "Transformable",
    "Circle",

    -- Gameplay components
    "Weapon",
    "Controllable",
    "Attitude",
    "HasGold",
    "Shield",
    "Hull",
    "Inventory",
    "Player"
})

function createPlayerCollection(entity)
    local components = {}
    -- Physical components
    local transformable = Transformable(Vector(100, 100), Vector(1, 0))
    table.insert(components, transformable)
    table.insert(components, Moving(Vector(0,0), constants.player.maxSpeed))
    table.insert(components, Rotating(constants.player.defaultRotationSpeed))
    table.insert(components, Accelerating(constants.player.defaultAcceleration, Vector(0,0)))
    table.insert(components, Circle(constants.player.diameter/2))

    -- Meta components
    table.insert(components, Player())
    table.insert(components, Controllable())
    table.insert(components, Attitude({Pirate=1}))

    -- GamePlay components
    table.insert(components, Hull(200))
    table.insert(components, HasGold(0))
    table.insert(components, Shield(200, 5))
    local turretCollection = Entity()
    turretCollection:addMultiple(createTurretCollection(turretCollection))
    table.insert(components, turretCollection)

    -- Graphic components
    table.insert(components, Muzzleparticles(100 ,500, 500, 3000))

        local ship = resources.images.player
        local ox, oy = ship:getWidth()/2, ship:getHeight()/2
    table.insert(components, (Drawable(ship, 1, sx, sy, ox, oy)))

    -- Creating particle system
    local particleComponent = Particle(resources.images.particle1, 5000, Vector(-constants.player.diameter*5/8, 0), {0.2, 1.2}, nil)
    table.insert(components, particleComponent)

    -- Local variables for particle position calculation
    local particle = particleComponent.particle
    local radian = transformable.direction:getRadian()
    local rotatedOffset = particleComponent.offset:rotate(transformable.direction:getRadian()):add(transformable.position)

    -- Particle properties
    particle:setPosition(rotatedOffset.x, rotatedOffset.y)
    particle:setEmissionRate(1000)
    particle:setAreaSpread("normal",9,9)
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

return createPlayerCollection
