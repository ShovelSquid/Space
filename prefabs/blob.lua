local C = require("components")

return function (x, y, size)
    return {
        position = C.position(x, y),
        velocity = C.velocity(),
        size = C.size(size or 1),
        health = C.health(1),
        name = C.name("jeoffrey"),
        -- reticle = C.reticle(),
        color = C.color(),
        speed = 200,
        lineWidth = C.lineWidth(),
    }
end