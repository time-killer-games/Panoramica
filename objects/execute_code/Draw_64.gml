if (alarm[0] > 0) exit

//Draw Transition (GameMaker Studio 1.x and GameMaker Studio 2.x)
display_set_gui_size(window_get_width(), window_get_height());
if (draw_transition = 1 && ImageLoaded = 1)
{
	if (transition_create = 1)
	{
		screen_save(working_directory + "/transition.png")
		transition = sprite_add(working_directory + "/transition.png", 0, 0, 0, 0, 0)
		generate_current_frame()
		for (i = 0; i < prevframe_maxhotspotcount; i += 1)
		{
			if (clicked[i] = 1)
			{
				ini_open(working_directory + "/run.ini")
				if (direction != ini_read_real(string(previousframe) + "-hotspot" + string(i), "panorama_horizontaldirection", direction))
				{
					direction = ini_read_real(string(previousframe) + "-hotspot" + string(i), "panorama_horizontaldirection", direction)
				}
				if (zdirection != ini_read_real(string(previousframe) + "-hotspot" + string(i), "panorama_verticaldirection", zdirection / MaximumVerticalAngle))
				{
					zdirection = ini_read_real(string(previousframe) + "-hotspot" + string(i), "panorama_verticaldirection", zdirection)
				}
				ini_close()
			}
		}
		transition_create = 0
	}
	d3d_set_projection_ortho(0, 0, window_get_width(), window_get_height(), 0)
	draw_sprite_stretched_ext(transition, 0, 0, 0, window_get_width(), window_get_height(), c_white, transition_alpha)
}

// draw handpoint cursor over transition
if (draw_transition = 1)
{
	if (enablepanoramamode = 1)
	{
		d3d_set_projection_ortho(0, 0, window_get_width(), window_get_height(), 0)
		draw_sprite(spr_cr_handpoint, 0, window_get_width() / 2, window_get_height() / 2)
		if (debug_mode = 1 || debug_game = 1)
		{
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_color(c_white)
			draw_set_font(Font)
			draw_text((window_get_width() / 2), (window_get_height() / 2) + 32, "(" + string(mousex) + "," + string(mousey) + ")")
		}
	}
	else 
	{
		d3d_set_projection_ortho(0, 0, window_get_width(), window_get_height(), 0)
		draw_sprite(spr_cr_handpoint, 0, window_mouse_get_x(), window_mouse_get_y())
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


