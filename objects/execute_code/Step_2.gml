if (alarm[0] > 0) exit

//Get the texel coordinates of the current texel the camera is facing
enablepanoramamode = frame_haspanoramaprojection
if (enablepanoramamode = 1)
{
	if (draw_transition = 0)
	{
		direction -= mouse_get_delta_x() / 20
		zdirection -= mouse_get_delta_y() / 20
		calculate_direction()
	}
	if (mouse_is_locked() = 1)
	{
		if (mouse_check_button_pressed(mb_right))
		{
			mouse_unlock()
		}
	}
	else {
		if (mouse_check_button_pressed(mb_left))
		{
			window_set_cursor(cr_none)
			mouse_lock()
		}
	}
	if (mouse_is_locked() = 0)
	{
		if (window_get_cursor() = cr_none)
		{
			window_set_cursor(cr_default)
		}
	}
}
else if (enablepanoramamode = 0)
{
	if (mouse_is_locked() = 1)
	{
		mouse_unlock()
	}
	if (window_get_cursor() = cr_default)
	{
		window_set_cursor(cr_none)
	}
	if (window_get_fullscreen())
	{
		mousex = round(window_mouse_get_x() * (windowwidth / display_get_width()))
		mousey = round(window_mouse_get_y() * (windowheight / display_get_height()))
	}
	else {
		mousex = window_mouse_get_x()
		mousey = window_mouse_get_y()
	}
}
