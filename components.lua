return {
    position = function(x, y)
        return {
            x = x or 0,
            y = y or 0
        }
    end,
    velocity = function(x, y)
        return {
            dx = x or 0,
            dy = y or 0
        }
    end,
    size = function(s)
        return {
            s = s or 0,
            r = s/2
        }
    end,
    health = function(h)
        return {
            hp = h or 0
        }
    end,
    name = function(s)
        return {
            label = s or ""
        }
    end,
    color = function(r, g, b, a)
        return {
            r = r or 0,
            g = g or 0,
            b = b or 0,
            a = a or 0
        }
    end,
    lineWidth = function(w)
        return {
            w = w or 0
        }
    end,
    parent = function(id)
        return {
            id = id or 0
        }
    end,
}