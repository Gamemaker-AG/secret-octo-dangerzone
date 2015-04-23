local Transformable = require("components/physic/Transformable")
local Drawable = require("components/graphic/Drawable")
local Circle = require("components/physic/Circle")
local Debris = require("components/gameplay/Debris")

return function(position, size)
    local amount = 32
    local starPositions = {}
    local subTileSize = size/4

    local tempCanvas = love.graphics.newCanvas(size*3/4, size*3/4)
    love.graphics.setCanvas(tempCanvas) 

    for i=0, 5, 1 do
        for j=0, 5, 1 do
            local starPos = {}
            local subTile = {}
            subTile.x = position.x-subTileSize+subTileSize*i
            subTile.y = position.y-subTileSize+subTileSize*j
            math.randomseed(2 * subTile.y + 2 * subTile.y * subTile.x - subTile.x + 2 * subTile.y)
            for k=0, 2, 1 do
                love.graphics.draw(resources.images.circle, math.random(0, subTileSize), math.random(0, subTileSize))
            end
        end
    end

    local quad = love.graphics.newQuad(subTileSize, subTileSize, size, size, 1, 1)

    local tempCanvas2 = love.graphics.newCanvas(size, size)
    love.graphics.setCanvas(tempCanvas2)
    love.graphics.draw(love.graphics.newImage(tempCanvas:getImageData()), quad, 0, 0)
    local finishedTile = love.graphics.newImage(tempCanvas2:getImageData())
    

    love.graphics.setCanvas() 

	local star = Entity()
	star:add(Transformable(position:clone():add(size/2)))
	star:add(Drawable(finishedTile))
	star:add(Circle(percentToPixels(1)))
	star:add(Debris())
	stack:current().engine:addEntity(star)
	return star
end
