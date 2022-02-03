if(place_meeting(x,y,oPlayer)){
	global.lastRoom = room;
	var rm = asset_get_index(roomTo);
	room_goto(rm);
}