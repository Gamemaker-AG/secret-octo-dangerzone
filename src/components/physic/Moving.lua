local Vector = require("helper/Vector")

return Component.create("Moving",
  {"speed", "maxSpeed"},
  {speed = Vector()})
