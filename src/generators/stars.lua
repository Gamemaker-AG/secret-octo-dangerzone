local Transformable = require("components/physic/Transformable")
local Drawable = require("components/graphic/Drawable")
local Circle = require("components/physic/Circle")
local Debris = require("components/gameplay/Debris")

return function(position, size)
    local amount = 32
    local starPositions = {}
    local subTileSize = size/4

    -- Create and set canvas for first drawing
    local bakeCanvas = love.graphics.newCanvas(subTileSize*6, subTileSize*6)
    love.graphics.setCanvas(bakeCanvas)


    for x=0, 5, 1 do
        for y=0, 5, 1 do
            local starPos = {}
            local subTile = {}

            -- Define subTile Position
            subTile.x = position.x-subTileSize+subTileSize*x
            subTile.y = position.y-subTileSize+subTileSize*y

            -- Get seed from subTile Position
            math.randomseed(2 * subTile.y + 2 * subTile.y * subTile.x - subTile.x + 2 * subTile.y)

            -- Draw Stars
            for k=0, 2, 1 do
                love.graphics.draw(resources.images.circle, subTile.x + math.random(0, subTileSize), subTile.y + math.random(0, subTileSize))
            end
        end
    end


    -- Create quad to cut off unneeded buffer
    local quad = love.graphics.newQuad(subTileSize, subTileSize, size, size, 1, 1)

    -- Create final buffer
    local cutCanvas = love.graphics.newCanvas(size, size)
    love.graphics.setCanvas(cutCanvas)

    -- Cut off buffer
    love.graphics.draw(bakeCanvas, quad, 0, 0)

    -- Restore standard canvas
    love.graphics.setCanvas()

    -- Create new entity with tile image
    local star = Entity()
    star:add(Transformable(position:clone()))
    star:add(Drawable(cutCanvas))
    star:add(Debris())
    stack:current().engine:addEntity(star)
    return star
end
