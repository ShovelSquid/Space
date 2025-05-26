local C = "components"

return function (x, y)
    return {
        position = C.position(x, y),
        velocity = C.velocity(),
        size = C.size(1),
        health = C.health(1),
        name = C.name("jeoffrey"),
        reticle = C.reticle(),
        color = C.color(),
        lineWidth = C.lineWidth(),
    }
end