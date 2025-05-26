local tiny = require "tiny"

local Move = tiny.processingSystem()
Move.filter = tiny.requireAll("position", "velocity")
function Move:process(e, dt)
    e.position.x = e.position.x + e.velocity.dx * dt
    e.position.y = e.position.y + e.velocity.dy * dt
end

return Move