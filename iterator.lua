require 'vec2'

local it_mt = {}
it_mt.__index = it_mt

function it_mt:__call()
	return self.f(self.t)
end

function it_mt:one(f)
	f = f or function() end
	return f(self())
end

function it_mt:each(f)
	f = f or function() end
	local r = {self()}
	while table.getn(r) > 0 do
		f(iterator(inext(), r):tuple())
		r = {self()}
	end
end

-- return 4 iteratior increments
function it_mt:tuple()
	return self(), self(), self(), self() -- 4
end

-- remove elements
function it_mt:filter(f)
	
end

-- transform elements
function it_mt:map(f)

end

-- keys only
function it_mt:keys()

end

-- indices/keys and values
function it_mt:enumerate()

end

-- tuple of a number of iterators
function it_mt:zip(it)

end

-- duplicate elements 
function it_mt:duplicate(count)

end

function it_mt:chain()

end

-- product of 2 iterators
function it_mt:product(it)
	local this = self
	local a = 0
	local b = 0

	it = it:cycle(function()
		a = this()
	end)

	return iterator(function()
		b = it()
		if a then return a, b end
	end)
end

function it_mt:combine(it)
	local this = self
	local a = 0
	local b = 0
	local cycles = 0

	it = it:cycle(function()
		a = this()
		range(1, cycles):each(function() if a then it() end end)
		cycles = cycles + 1
	end)

	return iterator(function()
		b = it()
		if a then return a, b end
	end)
end

function it_mt:cycle(roundf)
	local t = self:table()
	local index = 0
	return iterator(function()
		index = index < table.getn(t) and index + 1 or 1
		if roundf and index == 1 then roundf() end
		return t[index]
	end)
end

function it_mt:fold(f)

end

function it_mt:flatten()

end

function it_mt:count()

end

function it_mt:pairs()

end

function it_mt:print()
	local v = {self()}
	while table.getn(v) > 0 do
		print(iterator(inext(), v):tuple())
		v = {self()}
	end
end

function it_mt:table()
	local t = {}
	local v = self()
	while v do
		table.insert(t, v)
		v = self()
	end
	return t
end

function inext()
	local index = 0
	return function(t)
		index = index + 1
		return t[index]
	end
end

function iprev()
	local index = nil
	return function(t)
		index = index and index - 1 or table.getn(t)
		return t[index]
	end
end

function fnext()
	local key = nil
	return function(t)
		local r
		key, r = next(t, key)
		if key then return r end
	end
end

-- iterator for functions and tables
-- function: it = iterator(function() return 1 end, data?)
-- table:    it = iterator(fnext(), t)
-- array:    it = iterator(inext(), t)
-- array:    it = iterator(iprev(), t) -- iterate backwards
function iterator(f, t)
	local it = {}
	it.f = f or function() end
	it.t = t or {}
	
	return setmetatable(it, it_mt)
end

-- iterator builder

function range(from, to, step)
	step = step or 1
	from = from - 1
	return iterator(function()
		from = from + step
		if from <= to then return from end
	end)
end

-- rectangle
function range2(corner1, corner2, step)
	step = step or vec2(1, 1)
	local min_x, min_y = corner1:min(corner2):tuple()
	local max_x, max_y = corner1:max(corner2):tuple()
	local x = min_x
	local y = min_y - 1
	return iterator(function()
		y = y + step.x
		if max_y < y then
			x = x + step.y
			y = min_y
		end
		if x <= max_x then return x, y end
	end)
end
