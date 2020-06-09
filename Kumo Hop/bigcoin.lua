require "collisions"

local bigcoin = {}

-- metatabla: sirve para cambiar el comportamiento de la tabla a la que está asociada.
-- Con esto consigues que la tabla haga cosas que una tabla predefinidamente no puede realizar. 
-- Son comportamientos predefinidos según la 'key' que uses.
-- En el caso de la key .__index se usa cuando intentamos leer un elemento de la tabla que no está definido
bigcoin.__index = bigcoin

function newBigcoin(object)
	local n = object
	n.t = 0

	n.anim = newAnimation(lutro.graphics.newImage(
				"assets/bigcoin.png"), 32, 32, 1, 10)
				
	-- aqui asignamos la tabla bigcoin como metatabla de n
	return setmetatable(n, bigcoin)
	

end

function bigcoin:update(dt)
	self.t = self.t + dt
	self.y = self.y + math.cos(self.t*2.0)/6.0
	self.anim:update(dt)
end

function bigcoin:draw()
	self.anim:draw(self.x, self.y)
end

function bigcoin:on_collide(e1, e2, dx, dy)
	if e2.type == "ninja" or e2.type == "nube" then
		lutro.audio.play(sfx_coin)
		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
		gold = gold + 10
	end
end
