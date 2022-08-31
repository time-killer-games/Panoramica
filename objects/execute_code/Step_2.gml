//Get the texel coordinates of the current texel the camera is facing
enablepanoramamode = frame_haspanoramaprojection
if (enablepanoramamode = 1)
{
	if (draw_transition = 0)
	{
		if (mouse_x > cam_view_x + ((cam_view_x / 2) + cam_deadzone_left) && cam_view_x < (room_width - cam_view_width)) {
			global.pan_x = false
		} else if (mouse_x < cam_view_x + ((cam_view_x / 2) + cam_deadzone_right) && cam_view_x < (room_width - cam_view_width)) {
			global.pan_x = false
		} else {
			global.pan_x = true
		}
		
		if (mouse_y > cam_view_y + ((cam_view_y / 2) + cam_deadzone_up) && cam_view_y < (room_height - cam_view_height)) {
			global.pan_y = false
		} else if (mouse_y < cam_view_y + ((cam_view_y / 2) + cam_deadzone_down) && cam_view_y < (room_height - cam_view_height)) {
			global.pan_y = false
		} else {
			global.pan_y = true
		}
		
		if (global.mode == 1) {
			direction -= mouse_get_delta_x() / 20
			zdirection -= mouse_get_delta_y() / 20
		} else if (global.mode == 2) {
			if (global.pan_x == false) {
				direction -= (mouse_get_delta_x() / 50 + 0.1) * 0.2
				last_direction = direction
			} else if (global.pan_x == true) {
				pan_lerp_x = lerp(direction, last_direction + -mouse_get_delta_x() / 10, 0.05)
				direction = pan_lerp_x
			}
			
			if (global.pan_y == false) {
				zdirection -= (mouse_get_delta_y() / 50 + 0.1) * 0.2
				last_zdirection = zdirection
			} else if (global.pan_y == true) {
				pan_lerp_y = lerp(zdirection, last_zdirection + -mouse_get_delta_y() / 10, 0.05)
				zdirection = pan_lerp_y
			}
		}
		
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
