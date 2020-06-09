require "global"
require "tiled"
require "anim"
require "kumo"
require "obake"
--require "nube"
require "coin"
require "bigcoin"
require "porc"
require "elevator"
require "win"


function lutro.conf(t)
	t.width  = SCREEN_WIDTH
	t.height = SCREEN_HEIGHT
end


local add_entity_from_map = function(object)
	if object.type == "ground" then
		table.insert(entities, object)
	elseif object.type == "bridge" then
		table.insert(entities, object)
	elseif object.type == "stopper" then
		table.insert(entities, object)
	elseif object.type == "elevator" then
		table.insert(entities, newElevator(object))
	elseif object.type == "spikes" then
		table.insert(entities, object)
	elseif object.type == "coin" then
		table.insert(entities, newCoin(object))
	elseif object.type == "bigcoin" then
		table.insert(entities, newBigcoin(object))
	elseif object.type == "win" then
		win = youWin(object)
		table.insert(entities, win)
	elseif object.type == "porc" then
		table.insert(entities, newPorc(object))
	elseif object.type == "obake" then
		table.insert(entities, newObake(object))
	--elseif object.type == "nube" then
		--nube = newNube(object)
		--table.insert(entities, nube)
	elseif object.type == "kumo" then
		kumo = newKumo(object)
		table.insert(entities, kumo)
	end
end




function lutro.load()
	contador = 0
	camera_x = 0
	camera_y = 0
	gold = 0
	hp = 3
	lutro.graphics.setBackgroundColor(0, 0, 0)
	bg1 = lutro.graphics.newImage("assets/sky.png")
	bg2 = lutro.graphics.newImage("assets/dark.png")
	bg3 = lutro.graphics.newImage("assets/dark2.png")
	bg4 = lutro.graphics.newImage("assets/dark3.png")
	font = lutro.graphics.newImageFont("assets/font.png",
		" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/")
	fontdark = lutro.graphics.newImageFont("assets/fontdark.png",
		" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/")
	fontSmall = lutro.graphics.newImageFont("assets/font_small.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,-!$:;'")
	lutro.graphics.setFont(font)
	map = tiled_load("assets/mapa.json")
	tiled_load_objects(map, add_entity_from_map)

	sfx_coin = lutro.audio.newSource("assets/coin.wav")
	sfx_jump = lutro.audio.newSource("assets/jump.wav")
	sfx_step = lutro.audio.newSource("assets/step.wav")
	sfx_hit = lutro.audio.newSource("assets/hit.wav")
	sfx_porc = lutro.audio.newSource("assets/porc.wav")
	sfx_dead = lutro.audio.newSource("assets/dead.wav")
	sfx_gameover = lutro.audio.newSource("assets/gameover.wav")
	sfx_win = lutro.audio.newSource("assets/win.wav")

	
end



function lutro.update(dt)

	JOY_LEFT  = lutro.joystick.isDown(1,7)
	JOY_RIGHT = lutro.joystick.isDown(1,8)
	JOY_DOWN  = lutro.joystick.isDown(1,6)
	JOY_A     = lutro.joystick.isDown(1,9)
	JOY_B     = lutro.joystick.isDown(1,1)

	JOY2_LEFT  = lutro.joystick.isDown(2,7)
	JOY2_RIGHT = lutro.joystick.isDown(2,8)
	JOY2_DOWN  = lutro.joystick.isDown(2,6)
	JOY2_A     = lutro.joystick.isDown(2,5)

	if hp > 0 then
		for i=1, #entities do
			if entities[i].update then
				entities[i]:update(dt)
			end
		end

	else
		kumo:update(dt)
	end

	detect_collisions()
	
	

		if (JOY_B and contador == 0 and hp == 0) or (JOY_B and contador == 0 and  kumo.x > 2475 and kumo.x < 2550) then
		
		hp = 3
		kumo.dying = 0
		kumo.x = 2928
		kumo.y = 175
		--nube.x = 2650
		--nube.y = 175
		kumo.stance = "stand"
		kumo.width = 16
		kumo.height = 32
		kumo.xspeed = 0
		kumo.yspeed = 0
		kumo.xaccel = 200
		kumo.yaccel = 1000
		kumo.direction = "right"
		kumo.DO_JUMP = 0
		kumo.hit = 0
		bg1 = bg2
		
		end
	
	
	if kumo.x > 2830 and kumo.x < 5450 then
		contador = 1
	end
	
	
	
	if (JOY_B and contador == 1 and hp == 0) or (JOY_B and contador == 1 and  kumo.x > 5100 and kumo.x < 5445) then
		
		hp = 3
		kumo.dying = 0
		kumo.x = 5839
		kumo.y = 175
		--nube.x = 5807
		--nube.y = 175
		kumo.stance = "stand"
		kumo.width = 16
		kumo.height = 32
		kumo.xspeed = 0
		kumo.yspeed = 0
		kumo.xaccel = 200
		kumo.yaccel = 1000
		kumo.direction = "right"
		kumo.DO_JUMP = 0
		kumo.hit = 0
		bg1 = bg3

	end
	
	if kumo.x > 5700 and kumo.x < 8400 then
		contador = 2
	end
	
	if (JOY_B and contador == 2 and hp == 0) or (JOY_B and contador == 2 and  kumo.x > 8300 and kumo.x < 8400) then
		
		hp = 3
		kumo.dying = 0
		kumo.x = 8750
		kumo.y = 175
		--nube.x = 8700
		--nube.y = 175
		kumo.stance = "stand"
		kumo.width = 16
		kumo.height = 32
		kumo.xspeed = 0
		kumo.yspeed = 0
		kumo.xaccel = 200
		kumo.yaccel = 1000
		kumo.direction = "right"
		kumo.DO_JUMP = 0
		kumo.hit = 0
		bg1 = bg4

	end


	-- camera
	camera_x = - kumo.x + SCREEN_WIDTH/2 - kumo.width/2;
	if camera_x > 0 then
		camera_x = 0
	end
	if camera_x < -(map.width * map.tilewidth) + SCREEN_WIDTH then
		camera_x = -(map.width * map.tilewidth) + SCREEN_WIDTH
	end
end

function lutro.draw()
	lutro.graphics.clear()

	for i=0, 4 do
		lutro.graphics.draw(bg1, i*bg1:getWidth() + camera_x / 6, 0)
	end

	lutro.graphics.push()

	lutro.graphics.translate(camera_x, camera_y)

	tiled_draw_layer(map.layers[1])
	for i=1, #entities do
		if entities[i].draw then
			entities[i]:draw(dt)
		end
	end
	tiled_draw_layer(map.layers[2])

	lutro.graphics.pop()
	
	lutro.graphics.print("HP " .. hp .. "  POINTS " .. gold .. "  Contador " .. contador, 3, 6)

	if hp == 0 and contador == 0 then
		lutro.graphics.print("GAME OVER!", 120, 105)
		lutro.graphics.print("Press B to try again", 77, 120)
		lutro.graphics.setFont(fontdark)
		
	elseif hp == 0 and contador > 0 then
		lutro.graphics.print("GAME OVER!", 120, 105)
		lutro.graphics.print("Press B to try again", 77, 120)
		lutro.graphics.setFont(font)
	end
	
	if kumo.x > 2475 and kumo.x < 2600 and contador == 0 then
		lutro.graphics.print(" YOU WIN!", 130, 120)
		lutro.graphics.print("Press B", 130, 135)
		lutro.graphics.print("to play again", 125, 150)
		
	
	elseif kumo.x > 5400 and kumo.x < 2650 and contador > 0 then
		lutro.graphics.print(" YOU WIN!", 130, 120)
		lutro.graphics.print("Press B", 130, 135)
		lutro.graphics.print("to play again", 125, 150)
		lutro.graphics.setFont(font)
	end
	
	if contador == 2 and kumo.x > 10470 and kumo.x < 10660 then
		lutro.graphics.print("This is an odd thing to say, but...", 25, 90)
		lutro.graphics.print("isn't it your responsability to do", 25, 105)
		lutro.graphics.print("the right thing?", 100, 120)
		lutro.graphics.setFont(font)
	end
	
	if contador == 2 and kumo.x > 11407 then
		lutro.graphics.print("Press X to give the coins back", 120, 135)
		lutro.graphics.print("Press B to run away -as you did before-", 120, 150)
		lutro.graphics.setFont(fontSmall)
	end
end