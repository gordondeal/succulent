key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);
key_jump = keyboard_check_pressed(vk_space);

//calculate horizonatal move
var _move = climb ? 0 : key_right - key_left;
hsp = _move * walksp;

if((climb and key_jump) or !place_meeting(x,y,oLadder)) climb = false;

if(!climb) vsp = vsp + grv;
else vsp = (key_down - key_up) * climbsp;

var jump = key_jump and !key_down;
var drop = key_jump and key_down;

var ladder = instance_nearest(x,y,oLadder);
if(distance_to_object(ladder) > 10) ladder = false;
if(ladder && key_up && !climb){
	climb = true;
	y -= 2;
	x = ladder.x;
}



if (place_meeting(x,y+1,oWall) or place_meeting(x,y,oLadder)) && jump
{
	vsp = -jumpsp
	audio_play_sound(jump_sound, 1, 0);
	climb = false;
}

if(drop){
	climb = false;
}


//Horiz Collision
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{	
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp;

//vert collision
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{	
		y = y + sign(vsp);
	}
	if(vsp > 0) climb = false; //end climb for bottom collision
	vsp = 0;
	if(inTheAir and !audio_is_playing(land)) audio_play_sound(land, 1, 0);
	inTheAir = false;
	
} else {
	inTheAir = true;
}
y = y + vsp;


//animation
if(climb){
	if(vsp != 0) image_speed = 1;
	else image_speed = 0;
	sprite_index = sPlayerClimb
} else if (!place_meeting(x,y+1,oWall)){
	sprite_index = sPlayerA;
	image_speed = 0;
	if (vsp > 0) image_index = 1; else image_index = 0;
} else{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = sPlayer;
	}
	else
	{
	sprite_index = sPlayerR;	
	}
}
if (hsp != 0) image_xscale = sign(hsp);

if(
	!audio_is_playing(footstep1) and 
	sprite_index == sPlayerR and 
	round(image_index)%6 == 0){
	audio_play_sound(footstep1, 1, 0);
}

if(global.hp < 1){
	instance_destroy();
	room_goto(GameOver);
}

if(hpPrev > global.hp and global.hp >= 1){
	audio_play_sound(damage, 1, 0);
}

hpPrev = global.hp;





