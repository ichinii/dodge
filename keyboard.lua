keyboard = {}

function keyboard:left()
	return love.keyboard.isDown('a')
end

function keyboard:right()
	return love.keyboard.isDown('d')
end

function keyboard:up()
	return love.keyboard.isDown('w')
end

function keyboard:down()
	return love.keyboard.isDown('s')
end

function keyboard:dir()
	return vec2(
		(self:left() and -1 or 0) + (self:right() and 1 or 0),
		(self:down() and -1 or 0) + (self:up() and 1 or 0)
	)
end
