require "global"

function detect_collisions()
	for i = 1, #entities do
 		for j = 1, #entities do
 			if j ~= i then
 				local e1 = entities[i]
 				local e2 = entities[j]

				if not e1 or not e2 then
					return
				end

				if  e1.x < e2.x + e2.width
				and e1.x + e1.width > e2.x
				and e1.y < e2.y + e2.height
				and e1.height + e1.y > e2.y
				and e1.on_collide
				then
					local e1cx = e1.x + e1.width / 2.0
					local e2cx = e2.x + e2.width / 2.0
					local dx
					if e1cx < e2cx then
						dx = e2.x - (e1.x + e1.width)
					else
						dx =(e2.x + e2.width) - e1.x
					end

					local e1cy = e1.y + e1.height / 2.0
					local e2cy = e2.y + e2.height / 2.0
					local dy
					if e1cy < e2cy then
						dy = e2.y - (e1.y + e1.height)
					else
						dy = (e2.y + e2.height) - e1.y
					end

 					e1:on_collide(e1, e2, dx, dy)
				end
 			end
 		end
 	end
end

function solid_at(x, y, exclude)
	for i = 1, #entities do
		local e = entities[i];

		if  x >= e.x and x < e.x + e.width
		and y >= e.y and y < e.y + e.height
		and (e.type == "ground" or e.type == "bridge" or e.type == "elevator")
		and e ~= exclude
		then
			return e;
		end
	end
	return false;
end
