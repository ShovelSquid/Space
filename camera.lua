-- camera.lua --------------------------------------------------------------
local Camera = {}
Camera.__index = Camera

function Camera.new(x, y)
    return setmetatable({
        x = x or 0,
        y = y or 0,
        mousex = 0,
        mousey = 0,
        scale = 1,
        boundary = 4.5
    }, Camera)
end

-- keep (tx,ty) inside the “safe box”
function Camera:update(targx, targy)
    local width = love.graphics.getWidth()  / self.scale
    local height = love.graphics.getHeight() / self.scale
    local bounds = self.boundary
    self.mousex, self.mousey = self:getMouseWorld()

    local left = self.x + width / bounds
    local right = self.x + width - width / bounds
    local top = self.y + height / bounds
    local bottom = self.y + height - height / bounds

    if targx < left then
        self.x = targx - width / bounds
    elseif targx > right then
        self.x = targx - (width - width / bounds)
    end

    if targy < top then
        self.y = targy - height / bounds
    elseif targy > bottom then 
        self.y = targy - (height - height / bounds)
    end
end

-- drawing helpers ---------------------------------------------------------
function Camera:apply()
    love.graphics.push()
    love.graphics.scale(self.scale)
    love.graphics.translate(-self.x, -self.y)
end

function Camera:clear()
    love.graphics.pop() 
end

function Camera:zoom(factor)
    self.scale = math.max(0.2, math.min(5, self.scale * factor))
end

-- convert screen mouse pos to world coords respecting camera
function Camera:getMouseWorld()
    local mousex, mousey = love.mouse.getPosition()
    return self:worldToScreen(mousex, mousey)
end

function Camera:worldToScreen(x, y)
    return  x / self.scale + self.x,
            y / self.scale + self.y
end

return Camera









-- function updateCamera()
--     local screenWidth = love.graphics.getWidth() / camera.scale
--     local screenHeight = love.graphics.getHeight() / camera.scale

--     local leftBound = camera.x + screenWidth / camera.boundFrac
--     local rightBound = camera.x + 2 * screenWidth / camera.boundFrac
--     local topBound = camera.y + screenHeight / camera.boundFrac
--     local bottomBound = camera.y + 2 * screenHeight / camera.boundFrac

--     if player.x < leftBound then
--         camera.x = player.x - screenWidth / camera.boundFrac
--     elseif player.x > rightBound then
--         camera.x = player.x - 2 * screenWidth / camera.boundFrac
--     end

--     if player.y < topBound then
--         camera.y = player.y - screenHeight / camera.boundFrac
--     elseif player.y > bottomBound then
--         camera.y = player.y - 2 * screenHeight / camera.boundFrac
--     end
-- end