key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);
key_jump = keyboard_check_pressed(vk_space);
key_slide = keyboard_check_pressed(vk_shift);
key_attack = keyboard_check_pressed(ord("Z"));

switch(state){
	case "idle":
		//move
		var _move = key_right - key_left
		hsp = _move * walksp
		if(hsp != 0) state = "move"
		
		//vertical move
		vsp = vsp + grv
		
		//slide
		if(key_slide){
			hsp = image_xscale * walksp * 2
			image_index = 0
			audio_play_sound(slide_sound, 1, 0)
			state = "slide"
		}
		
		//jump
		if(key_jump and !key_down){
			vsp = -jumpsp
			audio_play_sound(jump_sound, 1, 0)
			state = "fall"
		}
		
		//climb
		var ladder = instance_nearest(x,y,oLadder)
		if(distance_to_object(ladder) > 10) ladder = false
		if(ladder && key_up){
			y -= 2
			x = ladder.x
			state = "climb"
		}
		
		//attack
		if(key_attack){
			image_index = 0
			audio_play_sound(choose(sword1, sword2, sword3, sword4), 1, 0)
			hsp = image_xscale * walksp
			state = "attack"
		}
		
		//sprite
		image_speed = 1
		sprite_index = sPlayer
		
		break
	
	case "move":
		//set horizontal speed
		var _move = key_right - key_left
		hsp = _move * walksp
		if(hsp == 0) state = "idle"
		
		//vertical move
		vsp = vsp + grv
	
		//slide
		if(key_slide){
			hsp = image_xscale * walksp * 2
			image_index = 0
			audio_play_sound(slide_sound, 1, 0)
			state = "slide"
		}
		
		//jump
		if(key_jump and !key_down){
			vsp = -jumpsp
			audio_play_sound(jump_sound, 1, 0)
			state = "fall"
		}
		
		//climb
		var ladder = instance_nearest(x,y,oLadder)
		if(distance_to_object(ladder) > 10) ladder = false
		if(ladder && key_up){
			y -= 2
			x = ladder.x
			state = "climb"
		}
		
		//attack
		if(key_attack){
			image_index = 0
			audio_play_sound(choose(sword1, sword2, sword3, sword4), 1, 0)
			hsp = image_xscale * walksp
			state = "attack"
		}
		
		//footsteps
		if(!audio_is_playing(footstep1) and round(image_index)%6 == 0){
			audio_play_sound(footstep1, 1, 0)
		}
		
		//sprite
		image_speed = 1
		sprite_index = sPlayerR
		if(hsp != 0) image_xscale = sign(hsp)
		
		break
		
	case "slide":
		//vertical move
		vsp = vsp + grv
	
		//jump
		if(key_jump and !key_down){
			vsp = -jumpsp
			audio_play_sound(jump_sound, 1, 0)
			state = "fall"
		}
		
		//fall
		//if(!place_meeting(x,y+1,oWall)) state = "fall"
		
		//sprite
		image_speed = 2
		sprite_index = sPlayerSlide
		
		break
		
	case "climb":
		//horizontal move
		hsp = 0
		
		//vertical move
		vsp = (key_down - key_up) * climbsp
		
		//jump
		if(key_jump and !key_down){
			vsp = -jumpsp
			audio_play_sound(jump_sound, 1, 0)
			state = "fall"
		}
		
		//fall
		if((key_jump and key_down) or !place_meeting(x,y,oLadder)) state = "fall"
		
		//sprite
		if(vsp != 0) image_speed = 1
		else image_speed = 0
		sprite_index = sPlayerClimb
		
		break
		
	case "fall":
		//horizontal move
		var _move = key_right - key_left
		hsp = _move * walksp
		
		//vertical move
		vsp = vsp + grv
		
		//climb
		var ladder = instance_nearest(x,y,oLadder)
		if(distance_to_object(ladder) > 10) ladder = false
		if(ladder && key_up){
			y -= 2
			x = ladder.x
			state = "climb"
		}
		
		//land
		//if(place_meeting(x,y+1,oWall)) state = "idle"
		
		//sprite
		sprite_index = sPlayerA
		image_speed = 0
		if (vsp > 0) image_index = 1; else image_index = 0
		
		break
	
	case "attack":
		//horizontal move
		hsp -= sign(hsp)/4
	
		//vertical move
		vsp = vsp + grv
		
		//attack COMBO
		if(key_attack){
			attackCombo = true
		}
		
		//sprite
		image_speed = 2
		sprite_index = sPlayerAttack
		
		break
}

//Horiz Collision
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{	
		x = x + sign(hsp)
	}
	hsp = 0
	if(state == "move" or state == "slide") state = "idle"
}
x = x + hsp

//vert collision
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{	
		y = y + sign(vsp)
	}
	if(state == "fall" and !audio_is_playing(land)) audio_play_sound(land, 1, 0);
	if(state == "fall") state = "idle"
	vsp = 0
} else {
	if(state != "climb") state = "fall"
}
y = y + vsp


//hp
if(global.hp < 1){
	instance_destroy()
	room_goto(GameOver)
}

if(hpPrev > global.hp and global.hp >= 1){
	audio_play_sound(damage, 1, 0)
}

hpPrev = global.hp

show_debug_message(state)


