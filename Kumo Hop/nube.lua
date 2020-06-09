require "collisions"

local nube = {}
nube.__index = nube

function newNube(object)
	local n = object
	n.width = 16
	n.height = 16
	n.xspeed = 0
	n.yspeed = 0
	n.xaccel = 200
	n.yaccel = 200
	n.direction = "left"
	n.stance = "fly"
	n.type = "nube"
	n.DO_JUMP = 0
	n.t = 0

	n.animations = {
		fly = {
			left  = newAnimation(lutro.graphics.newImage(
				"assets/nube.png"),  48, 48, 100, 10),
			right = newAnimation(lutro.graphics.newImage(
				"assets/nuberight.png"), 48, 48, 100, 10)
		},
	}

	n.anim = n.animations[n.stance][n.direction]
	return setmetatable(n, nube)
end

function nube:on_the_ground()
	return (solid_at(self.x + 1, self.y + 32, self)
		or solid_at(self.x + 15, self.y + 32, self))
		and self.yspeed >= 0
		and hp > 0
end

function nube:update(dt)

	self.t = self.t + dt
	self.y = self.y + math.cos(self.t*2.0) / 4.0
	
	-- gravity
	--if self:on_the_ground() then
		--self.yspeed = self.yspeed + self.yaccel * dt
		--self.y = self.y + dt * self.yspeed
	--end

	-- jumping
	if JOY2_A then
		self.y = self.y - 1
		self.yspeed = -50
	end

	if JOY2_DOWN then
		self.y = self.y + 1
		self.yspeed = 50
	end
	
	
	
	-- apply speed
	self.x = self.x + self.xspeed * dt;
	self.y = self.y + self.yspeed * dt;
	-- self.x = self.x + math.cos(self.t/2.0) / 2.0
	

	-- desacelerar
	
	if  not (JOY2_RIGHT and self.xspeed > 0)
	and not (JOY2_LEFT  and self.xspeed < 0)
	then
		if self.xspeed > 0 then
			self.xspeed = self.xspeed - 10
			if self.xspeed < 0 then
				self.xspeed = 0;
			end
		elseif self.xspeed < 0 then
			self.xspeed = self.xspeed + 10;
			if self.xspeed > 0 then
				self.xspeed = 0;
			end
		end
	end
	
	
	-- moverse
	if JOY2_LEFT then
		self.xspeed = self.xspeed - self.xaccel * dt;
		if self.xspeed < -150 then
			self.xspeed = -150
		end
		self.direction = "left";
	end

	if JOY2_RIGHT then
		self.xspeed = self.xspeed + self.xaccel * dt;
		if self.xspeed > 150 then
			self.xspeed = 150
		end
		self.direction = "right";
	end
	
	
	if JOY2_DOWN then
		self.yspeed = self.yspeed - self.yaccel * dt;
		if self.yspeed < -150 then
			self.yspeed = -150
		end
	end

	local anim = self.animations[self.stance][self.direction]
	-- always animate from first frame 
	if anim ~= self.anim then
		anim.timer = 0
	end
	self.anim = anim;

	self.anim:update(dt)
end

function nube:draw()
	self.anim:draw(self.x - 16, self.y - 16)
end

function nube:on_collide(e1, e2, dx, dy)

	if hp <= 0 then
		return
	end

	if e2.type == "ground" then

		if math.abs(dy) < math.abs(dx) and dy ~= 0 then
			if self.yspeed > 200 then
				lutro.audio.play(sfx_step)
			end
			self.yspeed = 0
			self.y = self.y + dy
		end

		if math.abs(dx) < math.abs(dy) and dx ~= 0 then
			self.xspeed = 0
			self.x = self.x + dx
		end

	elseif e2.type == "bridge" or e2.type == "elevator" then

		if math.abs(dy) < math.abs(dx) and dy ~= 0 and self.yspeed > 0
		and not JOY_DOWN
		and self.y + self.height > e2.y
		then
			self.yspeed = 0
			self.y = self.y + dy
			lutro.audio.play(sfx_step)
		end

	elseif e2.type == "spikes" then

		hp = 0

	elseif (e2.type == "obake" or e2.type == "porc") and self.hit == 0 then

		lutro.audio.play(sfx_hit)
		screen_shake = 0.25
		self.hit = 60
		if dx > 0 then
			self.xspeed = 200
		else
			self.xspeed = -200
		end
		self.y = self.y - 1
		self.yspeed = -1
		hp = hp - 1

	end

end