require 'vec2'
require 'iterator'

function collider(t)
	t = t or {}
end

function circle_collider(t)
	t = collider(t)
end

function convex_collider(t)
	t = collider(t)
end

local function collide_circle(a, b)
	if a == b then return end
	print(a, b)
end

local function collide_convex(a, b)
	if a == b then return end

end

local function collide_circle_convex(circle, convex)

end

function collisions(circles, convexs)
end
