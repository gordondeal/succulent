draw_set_font(arial)
for(var i = 0; i < array_length(options); i++){
	draw_set_color(c_white)
	if(i == menuIndex) draw_set_color(c_red)
	draw_text(20, 20 + i*50, options[i]);
}