draw_set_font(arial)
draw_set_color(c_white)
draw_text(camera_get_view_width(cam) * 0.5 - 50, camera_get_view_height(cam) * 0.5, "game over")

draw_text(camera_get_view_width(cam) * 0.5, camera_get_view_height(cam) - 50, "press any button to continue")