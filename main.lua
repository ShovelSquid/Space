local Entity = require("entity")
local Player = require("player")
local Camera = require("camera")

local scene = {
    cellSize = 40,
    hoveredEntity = nil,
}

local player = {
    x = 0,
    y = 0,
    radius = scene.cellSize/2,
    speed = 200
}

-- local camera = {
--     x = 0,
--     y = 0,
--     scale = 1,
--     boundFrac = 2.5,
-- }
local camera = Camera.new(0, 0)

local entities = {}

function love.load()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    player = Player.new(0, 0, scene.cellSize)
    
    -- add other entities
    for i = 1, 5 do
        table.insert(entities, Entity.new(math.random(-300, 300), math.random(-300, 300), scene.cellSize))
    end
end

function love.update(dt)
    -- WASD movement
    player:update(dt, camera, true)
    for _, e in ipairs(entities) do
        e:update(dt, camera)
        if e:isMouseOver(camera.mousex, camera.mousey) then scene.hoveredEntity = e end
    end
    if scene.hoveredEntity ~= nil then
        if scene.hoveredEntity:isMouseOver(camera.mousex, camera.mousey) then
        else
            scene.hoveredEntity = nil
        end
    end

    camera:update(player.x, player.y)
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
    love.graphics.push()
    love.graphics.scale(camera.scale)
    love.graphics.translate(-camera.x, -camera.y)

    drawGrid(scene.cellSize)
    drawHover()

    player:draw(camera)
    for _, e in ipairs(entities) do
        e:draw(camera)
    end

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

    love.graphics.pop()
end

function drawHover()
    if scene.hoveredEntity then
        local ex, ey = scene.hoveredEntity.x, scene.hoveredEntity.y
        --scamera:worldToScreen(scene.hoveredEntity.x, scene.hoveredEntity.y)
        -- tiny white circle
        love.graphics.push()
        love.graphics.setColor(1, 1, 1, 0.8)
        love.graphics.setLineWidth(2)
        love.graphics.circle("line", ex, ey, scene.hoveredEntity.radius + 3)

        -- health and name
        local label = string.format("%s \n(%d hp)", scene.hoveredEntity.name, scene.hoveredEntity.health)
        love.graphics.print(label, ex + 30, ey - 20)
        love.graphics.pop()
    end
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

    for x = startX, endX, cellSize do
        love.graphics.line(x, startY, x, endY)
    end
    for y = startY, endY, cellSize do
        love.graphics.line(startX, y, endX, y)
    end
    love.graphics.pop()
end