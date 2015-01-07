-- Core
local Vector = require("helper/Vector")
local constants = require("constants")

-- Graphic components
local Drawable = require("components/graphic/Drawable")
local Particle = require("components/particle/Particle")
local Muzzleparticles = require("components/graphic/Muzzleparticles")
-- Physic components
local Moving = require("components/physic/Moving")
local Rotating = require("components/physic/Rotating")
local Accelerating = require("components/physic/Accelerating")
local Transformable = require("components/physic/Transformable")

-- Gameplay components
local Weapon = require("components/gameplay/Weapon")
local Controllable = require("components/gameplay/Controllable")
local Attitude = require("components/gameplay/Attitude")
local Camera = require("components/gameplay/Camera")
local HasGold = require("components/gameplay/HasGold")
local Shield = require("components/gameplay/Shield")
local Hull = require("components/gameplay/Hull")
local Player = require("components/meta/Player")

local PlayerModel = class("PlayerModel", Entity)


function PlayerModel:__init()
    self:add(Transformable(Vector(100, 100), Vector(1, 0)))
    self:add(Moving(Vector(0,0), constants.player.maxSpeed))
    self:add(Rotating(constants.player.defaultRotationSpeed))
    self:add(Accelerating(constants.player.defaultAcceleration, Vector(0,0)))
    self:add(Attitude({Pirate=1}))
    self:add(Muzzleparticles(100 ,500, 500, 3000))
    self:add(Hull(200))
    self:add(Shield(200, 5))
    self:add(Player())
    local particleComponent = Particle(resources.images.particle1, 5000, Vector(-50, 0), {0.2, 1.2}, nil)
    self:add(particleComponent)
    local particle = particleComponent.particle

    -- Setzen der Position
    local transformable = self:get("Transformable")
    local radian = transformable.direction:getRadian()
    local rotatedOffset = particleComponent.offset:rotate(transformable.direction:getRadian()):add(transformable.position)

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

    local camera = Entity()
    camera:add(Camera(self))
    stack:current().engine:addEntity(camera)

    local ship = resources.images.player
    local sx, sy = constants.player.diameter/ship:getWidth(), constants.player.diameter/ship:getHeight()
    local ox, oy = ship:getWidth()*(2/3), ship:getHeight()/2
    self:add(Drawable(ship, 1, sx, sy, ox, oy))
    self:add(Controllable())
    self:add(HasGold(0))
end

return PlayerModel
