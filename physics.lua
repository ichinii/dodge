require 'vec2'
require 'iterator'

function collider(pos)
	return pos or vec2()
end

function circle_collider(pos, radius)
	local c = collider(pos)
	c.radius = radius
	return c
end

function convex_collider(pos)
	return collider(pos)
end

local function collide_circle(a, b)
	return (a - b):length() < a.radius, b.radius
end

local function collide_convex(a, b)
	-- implement hyperplane separation theorem
end

local function collide_circle_convex(circle, convex)

end

function shape(corners, pos)
	local index = 0
	local vertices = {}
	range(1, corners):each(function()
		table.insert(vertices, pos + vec2(math.cos(index), math.sin(index)))
		index = index + 1 / corners
	end)
	return vertices
end

function collisions(circles, convexs)
	iterator(inext(), {
		shape(3, vec2(0, 0)),
		shape(4, vec2(2, 2)),
		shape(5, vec2(3, 3))
	}):combine()
		:filter(function(a, b) return a == b end)
		:each(collide_convex)
end
