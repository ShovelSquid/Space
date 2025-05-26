local tiny = require "tiny"

local Render = tiny.system()
Render.filter = tiny.requireAll("position", "size", "color", "lineWidth")
function Render:draw(e)
    love.graphics.push()
    love.graphics.setColor(e.color.r, e.color.g, e.color.b, e.color.a)
    love.graphics.setLineWidth(e.lineWidth.w)
    love.graphics.circle("line", e.position.x, e.position.y, e.size.r)
    love.graphics.pop()
end

return Render