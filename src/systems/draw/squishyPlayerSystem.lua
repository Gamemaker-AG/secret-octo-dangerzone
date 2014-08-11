SquishyPlayerSystem = class("SquishyPlayerSystem", System)

function SquishyPlayerSystem:playerMoved(event)
	local player = table.firstElement(stack:current().engine:getEntityList("PlayerNodeComponent"))
	local drawable = player:getComponent("DrawableComponent")

	local anim = player:getComponent("AnimateComponent")
	if anim then 
		tween.stop(anim.tweenID)
		if anim.sx then drawable.sx = anim.sx end
		if anim.sy then drawable.sy = anim.sy end
		player:removeComponent("AnimateComponent")
	end
	local scaleKey = "sy"
	if event.direction == "up" or event.direction == "down" then scaleKey = "sx" end

	local targetObject = {}
	targetObject[scaleKey] = drawable[scaleKey] - (drawable[scaleKey]/10)

	player:addComponent(AnimateComponent(0.1, drawable, targetObject, "outQuad", 
		self.animationDone, {self, scaleKey, drawable[scaleKey], player}))
	player:getComponent("AnimateComponent")[scaleKey] = drawable[scaleKey]
end

function SquishyPlayerSystem:animationDone(scaleKey, originalSize, player)
	local targetObject = {}
	targetObject[scaleKey] = originalSize
	if player:getComponent("AnimateComponent") == nil then
		player:addComponent(AnimateComponent(0.1, player:getComponent("DrawableComponent"), targetObject, "inQuad"))
	end
	player:getComponent("AnimateComponent")[scaleKey] = originalSize
end
