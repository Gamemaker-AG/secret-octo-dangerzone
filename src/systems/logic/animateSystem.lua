AnimateSystem = class("AnimateSystem", System)

function AnimateSystem:update(dt)
	for index, entity in pairs(self.targets) do
		local anim = entity:getComponent("AnimateComponent")
		if anim.tweenID == nil then
			anim.tweenID = tween(anim.time, anim.subject, anim.target, anim.easing, self.animationDone, self, entity)
		end
	end
	tween.update(dt)
end

function AnimateSystem:animationDone(entity)
	local anim = entity:getComponent("AnimateComponent")
	if anim then
		entity:removeComponent("AnimateComponent")
		if anim.callback then anim.callback(unpack(anim.callbackArgs)) end
	end
end

function AnimateSystem:getRequiredComponents()
	return {"AnimateComponent"}
end