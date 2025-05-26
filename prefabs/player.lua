local C = require "components"
local blob = require "prefabs.blob"

return function(x, y)
    local p = blob(x, y)
    p.playerTag = C.playerTag()
    return p
end

-- return function (x, y)
--     return {
--         position = position()
--     }
-- end

-- local Entity = require("entity")

-- Player = setmetatable({}, { __index = Entity })  -- Inherit from Entity
-- Player.__index = Player

-- function Player.new(x, y, size)
--     local self = setmetatable(Entity.new(x, y, size), Player)  -- Call Entity constructor
--     self.isPlayer = true
--     return self
-- end

-- function Player:update(dt, camera, input)
--     -- Custom player-specific behavior
--     if input then
--         if love.keyboard.isDown("w") then self.y = self.y - self.speed * dt end
--         if love.keyboard.isDown("s") then self.y = self.y + self.speed * dt end
--         if love.keyboard.isDown("a") then self.x = self.x - self.speed * dt end
--         if love.keyboard.isDown("d") then self.x = self.x + self.speed * dt end
--     end
--     self:updatereticle(camera)
-- end

-- return Player