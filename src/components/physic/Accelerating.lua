local Vector = require("helper/Vector")

return Component.create("Accelerating",
  {"defaultAcceleration", "acceleration"},
  {acceleration = Vector()})
