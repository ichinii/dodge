require 'vec2'
require 'iterator'
require 'physics'

function create_player1(controller)
	local player = {}
	player.controller = controller
	player.body = physics:create_circle(vec2(4, 4), .5, 'dynamic')
	player.tail = {player.body}
	range(1, 2):each(function(i)
		print(player.tail[1])
		local body = physics:create_circle(vec2(5 + i * 2 - i * i, 4), .5, 'dynamic')
		local x1, y1 = player.tail[i]:getPosition()
		local x2, y2 = body:getPosition()
		love.physics.newDistanceJoint(player.tail[i], body, x1, y1, x2, y2)
		table.insert(player.tail, body)
	end)

	function player:update(dt)
		local speed = 10
		local dir = self.controller:dir():normalize() * speed
		self.body:setLinearVelocity(dir:tuple())
	end

	return player
end
