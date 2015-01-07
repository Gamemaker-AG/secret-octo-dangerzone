local GameOverState = require("states/GameOverState")

local AddingGold = require("events/AddingGold")

local Vector = require("helper/Vector")

local Particle = require("components/particle/Particle")

local DestroySystem = class("DestroySystem", System)

function DestroySystem:update(dt)
    for _, entity in pairs(self.targets) do
        if entity:has("Particle") then
            local particle = Entity()
            particle:add(entity:get("Transformable"))
            particle:add(entity:get("Particle"))
            particle:get("Particle").emitterlife = 0
        end
        if entity:has("DropsGold") then
            stack:current().eventmanager:fireEvent(AddingGold(entity))
        end
        if entity:has("Player") then
            stack:push(GameOverState())
            break
        end
        -- creating EXPLOSION
        local explosion = Entity()
        explosion:add(entity:get("Transformable"))

        local particleComponent = Particle(resources.images.particle1, 5000, Vector(0, 0), {0.2, 0.6}, 0.5)
        explosion:add(particleComponent)
        local particle = particleComponent.particle
    
            -- Setzen der Position
            local transformable = entity:get("Transformable")
            local radian = transformable.direction:getRadian()
            local rotatedOffset = particleComponent.offset:rotate(transformable.direction:getRadian()):add(transformable.position)
            local mass
            if entity:has("Pirate") then
                mass = 50
            else
                mass = 5
            end

            local relation = 1
            particle:setPosition(rotatedOffset.x, rotatedOffset.y)
            particle:setEmissionRate(mass*8)
            particle:setSpeed(mass*3, mass*3)
            particle:setSizes(2.5, 2.8)
            particle:setColors(255, 255, 255, 255,
                        255, 255, 0, 255,
                        200, 0, 0, 255,
                        255, 100, 0, 155)
            particle:setEmitterLifetime(0.6) -- Zeit die der Partikelstrahl anhält
            particle:setParticleLifetime(0.5, 0.6) -- setzt Lebenszeit in min-max
            -- particle:setOffset(x, y) -- Punkt um den der Partikel rotiert
            particle:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
            particle:setDirection(0)
            particle:setSpread(360)
            particle:setRadialAcceleration((mass*-7.5)*relation, (mass*-7.5)*relation)
            particle:start()

        stack:current().engine:addEntity(explosion)

        stack:current().engine:removeEntity(entity)
    end
end


function DestroySystem:requires()
    return {"Destroyed"}
end


return DestroySystem
