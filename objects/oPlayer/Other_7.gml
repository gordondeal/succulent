/// @description Insert description here
// You can write your code in this editor
if(sprite_index == sPlayerSlide){
	state = "idle"
}
if(sprite_index == sPlayerAttack){
	if(attackCombo){
		image_index = 0
		audio_play_sound(choose(sword1, sword2, sword3, sword4), 1, 0)
		hsp = image_xscale * walksp
		state = "attack"
		attackCombo = false
	} else {
		state = "idle"
	}
}