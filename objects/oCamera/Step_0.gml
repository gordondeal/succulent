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

if (layer_exists("Clouds"))
{
	layer_x("Clouds",x/6)	
}
if (layer_exists("Spikes"))
{
layer_x("Spikes",x/4)
}
if (layer_exists("Clouds2"))
{
	layer_x("Clouds2",x/8)	
}
if (layer_exists("Moon"))
{
layer_x("Moon",x/10)
}
if (layer_exists("Plateaus"))
{
	layer_x("Plateaus",x/5)	
	
}