local Entity = {}
Entity.__index = Entity

function Entity.new(x, y, size)
    local self = setmetatable({}, Entity)
    self.x = x
    self.y = y
    self.name = "greg"
    self.size = size or 60
    self.radius = size/2 or 30
    self.health = 3
    self.reticleOffset = self.radius/1.5
    self.color = {1, 0, 0}
    self.speed = 200
    self.reticle = {x = 0, y = 0}
    self.lineWidth = 3
    self.reticleWidth = 4
    return self
end

function Entity:update(dt, camera, input)
    self:updatereticle(camera)
    -- self:updatePosition(dt)
end

function Entity:updatereticle(camera)
    -- Update reticle direction toward mouse (default)
    local mx, my = love.mouse.getPosition()
    local worldMouseX = mx / camera.scale + camera.x
    local worldMouseY = my / camera.scale + camera.y
    local angle = math.atan2(worldMouseY - self.y, worldMouseX - self.x)

    self.reticle.x = self.x + math.cos(angle) * (self.radius + self.reticleOffset)
    self.reticle.y = self.y + math.sin(angle) * (self.radius + self.reticleOffset)
end

-- add anywhere in entity table (below existing methods is fine)
function Entity:isMouseOver(mousex, mousey)
    local dx = mousex - self.x
    local dy = mousey - self.y
    return (dx * dx + dy * dy) <= (self.radius * self.radius)
end

function Entity:updatePosition(dt)

end

function Entity:draw(camera)
    -- Get angle to mouse
    love.graphics.push()
    love.graphics.setColor(1, 0, 0)
    love.graphics.setLineWidth(self.lineWidth)
    love.graphics.circle("line", self.x, self.y, self.radius)
    love.graphics.circle("fill", self.reticle.x, self.reticle.y, self.reticleWidth)
    love.graphics.pop()
end


return Entity