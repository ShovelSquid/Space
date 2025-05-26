return {
    position = function(x, y)
        return {
            x = x,
            y = y
        }
    end,
    velocity = function(x, y)
        return {
            dx = x,
            dy = y
        }
    end,
    radius = function(r)
        return {
            r = r
        }
    end,
    health = function(h)
        return {
            hp = h
        }
    end,
    name = function(s)
        return {
            label = s
        }
    end,
    color = function(r, g, b, a)
        return {
            r = r,
            g = g,
            b = b,
            a = a
        }
    end,
    lineWidth = function(w)
        return {
            w = w
        }
    end
}