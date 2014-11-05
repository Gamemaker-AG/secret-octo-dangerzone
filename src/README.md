lovetoys-template
=================

A bunch of usefull components, systems and other helper for use in game development with aid of lovetoys

## drawableDrawSystem.lua

This system is designed to draw images with given Love2d methods. It manages all entities with an `PositionComponent`,  a `DrawableComponent` and a `ZIndex` component. The `ZIndex` component is used for managing different layers in your graphics. The higher the `ZIndex` the higher the layer of the drawed image.

## stringDrawSystem.lua

The `StringDrawSystem` is designed to draw strings with values that need to be updated during gameplay. 
        entity:add(StringComponent(font, {255, 255, 255, 255}, "Player's life:  %i", {{player:get("LifeComponent"), "life"}}))
In this example the life of the player is accessible in `player:get("LifeComponent").life`. It has to be this circumstantial, because there are no pointer in Lua and you need to access the value from the table dynamically with the given index to get the updating value.

## Particles

Every entity with an `ParticleComponent` gets his particle system automatically updated, drawed and deleted, if you add `particleDrawSystem.lua` and `particleUpdateSystem.lua` to your engine. Additionally you can add `particlePositionSyncSystem.lua`. This system syncs the position of the particle to the position given entity. The entity needs to contain a `ParticleComponent` and a `PositionComponent`. For automatic deletion you need to add `particleTimerComponent.lua`.

The init method of the `ParticleComponent` needs the particle image and buffer amount.
        ParticleComponent:__init(image, buffer)
The Love2d particle system itself can be accessed and adjusted with `entity:get( "ParticleComponent").particle`

The ParticleTimerComponent needs following parameter:  
`ParticleTimerComponent:__init(particlelife, emitterlife)`  
`emitterlife`: The amount of time the particlesystem should run.  
`particlelife`:  The amount of time the particles stay after stopping the particle emitter.  

## bodyDestroySystem.lua

Destroys all Love2d physic bodies that got a `BodyDestroyComponent`. This is needed to destroy bodies inside the update loop and avoid doing it during collision callbacks. Otherwise there can occur problems with the Love2d physics engine, if they try to access a destroyed body.

## physicsPositionSyncSystem.lua

This System is highly recommended. It syncs your PositionComponent with your `PhysicsComponent`. Otherwise you got two different positions inside the same entity.

## timerSystem.lua

The `TimerSystem` manages all entities with a `TimerComponent` and fires the event of the component to the current eventmanager. Usefull for all kinds of timed events.

## mainKeySystem.lua

An example for how to deal with key events.  
There is an example on how to add the system to the eventmanager in menuState.lua

## mainMousePressedSystem

An example for how to deal with mouse events.  
There is an example on how to add the system to the eventmanager in menuState.lua

