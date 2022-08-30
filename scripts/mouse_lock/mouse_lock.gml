function mouse_lock() {
	if (!global.g_mouse_locked) {
		global.g_mouse_locked = true;
		global.g_mouse_lock_lcr = window_get_cursor();
		if (global.g_mouse_lock_lcr != cr_none) window_set_cursor(cr_none);
		global.g_mouse_lock_lx = window_mouse_get_x();
		global.g_mouse_lock_ly = window_mouse_get_y();
	}
}
