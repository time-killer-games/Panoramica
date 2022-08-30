function mouse_lock_init() {
	global.g_mouse_delta_x = 0;
	global.g_mouse_delta_y = 0;
	global.g_mouse_locked = false;
	global.g_mouse_was_locked = false;
	global.g_mouse_lock_lcr = cr_default;
	global.g_mouse_lock_lx = 0;
	global.g_mouse_lock_ly = 0;
}
