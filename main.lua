local Entity = require("entity")
local Player = require("player")

local scene = {
    cellSize = 40,
}

local player = {
    x = 0,
    y = 0,
    radius = scene.cellSize/2,
    speed = 200
}

local camera = {
    x = 0,
    y = 0,
    scale = 1,
    boundFrac = 2.5,
}

local entities = {}

function love.load()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    
    -- table.insert(entities, player)

    -- add other entities
    
end

function love.update(dt)
    -- WASD movement
    player:update(dt, true)
    for _, e in ipairs(entities) do
        e:update(dt)
    end

    updateCamera()
end

function updateCamera()
    local screenWidth = love.graphics.getWidth() / camera.scale
    local screenHeight = love.graphics.getHeight() / camera.scale

    local leftBound = camera.x + screenWidth / camera.boundFrac
    local rightBound = camera.x + 2 * screenWidth / camera.boundFrac
    local topBound = camera.y + screenHeight / camera.boundFrac
    local bottomBound = camera.y + 2 * screenHeight / camera.boundFrac

    if player.x < leftBound then
        camera.x = player.x - screenWidth / camera.boundFrac
    elseif player.x > rightBound then
        camera.x = player.x - 2 * screenWidth / camera.boundFrac
    end

    if player.y < topBound then
        camera.y = player.y - screenHeight / camera.boundFrac
    elseif player.y > bottomBound then
        camera.y = player.y - 2 * screenHeight / camera.boundFrac
    end
end

function love.wheelmoved(x, y)
    if y > 0 then camera.scale = camera.scale * 1.1
    elseif y < 0 then camera.scale = camera.scale * 0.9
    end
    -- Clamp zoom level
    if camera.scale < 0.2 then camera.scale = 0.2
    elseif camera.scale > 5 then camera.scale = 5
    end
end


function love.draw()
    -- love.graphics.push()
    -- love.graphics.scale(camera.scale)
    -- love.graphics.translate(-camera.x, -camera.y)
    camera:apply()

    drawGrid(scene.cellSize)

    camera:clear()

    -- player:draw(camera)
    -- for _, e in ipairs(entities) do
    --     e:draw(camera)
    -- end

    -- Get angle to mouse (adjusted for camera and zoom)
    -- local mx, my = love.mouse.getPosition()
    -- local worldMouseX = mx / camera.scale + camera.x
    -- local worldMouseY = my / camera.scale + camera.y
    -- local angle = math.atan2(worldMouseY - player.y, worldMouseX - player.x)

    -- -- Draw hollow red circle
    -- love.graphics.setColor(1, 0, 0)
    -- love.graphics.setLineWidth(2)
    -- love.graphics.circle("line", player.x, player.y, player.radius)

    -- -- Draw small dot on the circumference pointing to mouse
    -- local cx = player.x + math.cos(angle) * (player.radius + player.radius/2)
    -- local cy = player.y + math.sin(angle) * (player.radius + player.radius/2)
    -- love.graphics.circle("fill", cx, cy, 5)

    -- love.graphics.pop()
end

function drawGrid(cellSize)
    love.graphics.push()
    love.graphics.setColor(0.3, 0.3, 0.3)
    love.graphics.setLineWidth(2)
    local width = love.graphics.getWidth() + camera.x
    local height = love.graphics.getHeight() + camera.y

    local screenWidth = love.graphics.getWidth() / camera.scale
    local screenHeight = love.graphics.getHeight() / camera.scale

    local startX = math.floor(camera.x / cellSize) * cellSize
    local startY = math.floor(camera.y / cellSize) * cellSize
    local endX = camera.x + screenWidth
    local endY = camera.y + screenHeight

    for x = startX, endX + cellSize, cellSize do
        love.graphics.line(x, startY, x, endY)
    end
    for y = startY, endY + cellSize, cellSize do
        love.graphics.line(startX, y, endX, y)
    end
    love.graphics.pop()
end