/// @description d3d - enable 3d
function d3d_start(mode) {

	var ret = global.__d3d;
	global.__d3d = true;
	//camera_apply(global.__d3dCamera);
	gpu_set_ztestenable(true);
	gpu_set_zwriteenable(true);
	
	global.mode = mode
	
	return ret;



}
