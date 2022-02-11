/// @description Insert description here
// You can write your code in this editor
if (instance_exists(follow))
{
	xTo = follow.x;
	yTo = follow.y;
}

//update object position
x += (xTo - x) / 25;
y += (yTo - y) / 25;

x = clamp(x,view_w_half,room_width-view_w_half);
y = clamp(y,view_h_half,room_height-view_h_half);

//Update camera view
camera_set_view_pos(cam,x-view_w_half,y-view_h_half);

if (layer_exists("foreground"))
{
	layer_x("foreground",x/5)
	layer_y("foreground",y-y/10-view_h_half)
}
if (layer_exists("midground"))
{
	layer_x("midground",x/6)	
	layer_y("midground",y-y/15-view_h_half/2)
}
if (layer_exists("background"))
{
	layer_x("background",x/8)
	layer_y("background",y-view_h_half/2)
}
