require 'vec2'

local it_mt = {}
it_mt.__index = it_mt

function it_mt:__call()
	return self:f(self.t, self.k)
end

-- 
function it_mt:each(f)
	local v = self()
	while v do
		f(v)
		v = self()
	end
end

-- remove elements
function it_mt:filter(f)
	
end

-- transform elements
function it_mt:map(f)

end

-- keys only
function it_mt:key()

end

-- indices/keys and values
function it_mt:enumerate()

end

-- tuple of a number of iterators
function it_mt:zip(...)

end

-- duplicate elements 
function it_mt:duplicate(count)

end

function it_mt:chain()

end

function it_mt:cross()

end

function it_mt:cycle()

end

function it_mt:fold()

end

function it_mt:flatten()

end

function it_mt:count()

end

function it_mt:pairs()

end

function it_mt:print()
	local val = self()
	while val do
		print(val)
		val = self()
	end
end

function it_mt:table()
	local t = {}
	local v = {self()}
	while #v > 0 do
		if #v == 1 then
			table.insert(v[1])
		else
			table.insert(v)
		end
	end
	return t
end

function forward(t)
	t = t or {}
	local i = 0
	return iterator(function()
		i = i + 1
		return t[i]
	end)
end

function backward(t)
	t = t or {}
	local i = table.getn(t) + 1
	return iterator(function()
		i = i - 1
		return t[i]
	end)
end

function iterator(f)
	local it = {}
	it.f = f or function() end
	
	return setmetatable(it, it_mt)
end

function range(from, to, step)
	step = step or 1
	from = from - 1
	return iterator(function()
		from = from + step
		if from <= to then return from end
	end)
end

function range2(corner1, corner2, step)
	step = step or 1
	local min_x, min_y = corner1:min(corner2):tuple()
	local max_x, max_y = corner1:max(corner2):tuple()
	local x = min_x
	local y = min_y - 1
	return iterator(function()
		y = y + 1
		if max_y < y then
			x = x + 1
			y = min_y
		end
		if x <= max_x then return x, y end
	end)
end
