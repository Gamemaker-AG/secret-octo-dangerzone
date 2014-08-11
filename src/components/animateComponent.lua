AnimateComponent = class("AnimateComponent", Component)

function AnimateComponent:__init(time, subject, target, easing, callback, callbackArgs)
	self.time = time
	self.subject = subject
	self.target = target
	self.easing = easing
	self.callback = callback
	if callbackArgs then self.callbackArgs = callbackArgs else self.callbackArgs = {} end
	self.tweenID = nil
end