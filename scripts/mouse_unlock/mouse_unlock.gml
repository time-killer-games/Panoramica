function mouse_unlock() {
	if (global.g_mouse_locked) {
		global.g_mouse_locked = false;
		window_set_cursor(global.g_mouse_lock_lcr);
		window_mouse_set(global.g_mouse_lock_lx, global.g_mouse_lock_ly);
	}
}
