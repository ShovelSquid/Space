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
    size = function(s)
        return {
            s = s,
            r = s/2
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
    end,
    playerTag = function(bool)
        return {
            yes = bool or true,
        }
    end,
    parent = function(id)
        return {
            id = id,
        }
    end,
}