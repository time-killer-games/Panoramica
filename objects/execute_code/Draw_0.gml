//Draw 2D picture frame
if (enablepanoramamode = 0 && ImageLoaded = 1)
{
	d3d_set_projection_ortho(0, 0, window_get_width(), window_get_height(), 0)
	draw_sprite_stretched(Transparent, image_index, 0, 0, window_get_width(), window_get_height())
}

//Draw 3D projected panoramic frame
if (enablepanoramamode = 1 && ImageLoaded = 1)
{
	draw_set_color(c_white)
	d3d_set_projection_ext(x, y, z,
	x + cos(degtorad(direction)) * cos(degtorad(zdirection)),
	y - sin(degtorad(direction)) * cos(degtorad(zdirection)),
	z + sin(degtorad(zdirection)), 0, 0, 1, 60, 4 / 3, 0, 1024)
	d3d_draw_cylinder(-100, -100, 350 / panoramaaspectratio, 100, 100,
	-350 / panoramaaspectratio, tex[image_index], 1, 1, 0, 700)
}

// Draw messages
if (draw_transition = 0 && ImageLoaded = 1)
{
	if (nextcheck = 1)
	{
		for (i = 0; i < frame_maxhotspotcount; i += 1)
		{
			if (showmessage[i] = 1)
			{
				d3d_set_projection_ortho(0, 0, window_get_width(), window_get_height(), 0)
				draw_set_font(Font)
				draw_set_valign(fa_top)
				draw_set_halign(fa_left)
				draw_set_color(c_black)
				draw_rectangle(0, window_get_height() - string_height(messagetext[i]), window_get_width(), window_get_height(), 0)
				draw_set_valign(fa_top)
				draw_set_halign(fa_center)
				draw_set_color(c_white)
				texture_set_interpolation(1)
				draw_text(window_get_width() / 2, window_get_height() - string_height(messagetext[i]), messagetext[i])
				texture_set_interpolation(0)
			}
		}
	}
}

//Draw Cursor
if (draw_transition = 0 && ImageLoaded = 1)
{
	if (enablepanoramamode = 1)
	{
		if (mouse_is_locked() = 1)
		{
			d3d_set_projection_ortho(0, 0, window_get_width(), window_get_height(), 0)
			if (over_hotspot = 1)
			{
				if (global.mode == 1) {
					draw_sprite(spr_cr_handpoint, 0, window_get_width() / 2, window_get_height() / 2)
				} else if (global.mode == 2) {
					draw_sprite(spr_cr_handpoint, 0, window_mouse_get_x(), window_mouse_get_y())
				}
			}
			draw_set_blend_mode(bm_zero)
			if (over_hotspot = 0)
			{
				
				if (global.mode == 1) {
					draw_sprite(spr_cr_cross, 0, window_get_width() / 2, window_get_height() / 2)
				} else if (global.mode == 2) {
					draw_sprite(spr_cr_cross, 0,  window_mouse_get_x(), window_mouse_get_y())
				}
			}
			draw_set_blend_mode(bm_normal)
			if (debug_mode = 1 || debug_game = 1)
			{
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				draw_set_color(c_white)
				draw_set_font(Font)
				draw_text(window_get_width() / 2, window_get_height() / 2 + 32, "(" + string(mousex) + "," + string(mousey) + ")")
			}
		}
	}
	else 
	{
		d3d_set_projection_ortho(0, 0, window_get_width(), window_get_height(), 0)
		if (over_hotspot = 1)
		{
			draw_sprite(spr_cr_handpoint, 0, window_mouse_get_x(), window_mouse_get_y())
		}
		draw_set_blend_mode(bm_zero)
		if (over_hotspot = 0)
		{
			draw_sprite(spr_cr_cross, 0, window_mouse_get_x(), window_mouse_get_y())
		}
		draw_set_blend_mode(bm_normal)
		if (debug_mode = 1 || debug_game = 1)
		{
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_color(c_white)
			draw_set_font(Font)
			draw_text(window_mouse_get_x(), window_mouse_get_y() + 32, "(" + string(mousex) + "," + string(mousey) + ")")
		}
	}
}
