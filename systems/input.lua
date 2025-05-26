local tiny = require "tiny"

local Input = tiny.system()
Input.filter = tiny.requireAll("player", "velocity")
function Input:update(e, dt)
    if love.keyboard.isDown("w") then e.velocity.y = -e.speed * dt end
    if love.keyboard.isDown("s") then e.velocity.y = e.speed * dt end
    if love.keyboard.isDown("a") then e.velocity.x = -e.speed * dt end
    if love.keyboard.isDown("d") then e.velocity.x = e.speed * dt end
end