function mouse_lock_update() {
	var locked;
	locked = mouse_is_locked();
	global.g_mouse_delta_x = 0;
	global.g_mouse_delta_y = 0;
	if (locked) {
	var nx, ny;
	nx = window_get_width() div 2;
	ny = window_get_height() div 2;
	if (global.g_mouse_was_locked) {
	global.g_mouse_delta_x = window_mouse_get_x() - nx;
	global.g_mouse_delta_y = window_mouse_get_y() - ny;
	}
	window_mouse_set(nx, ny);
	}
	global.g_mouse_was_locked = locked;
}
