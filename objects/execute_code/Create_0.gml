d3d_start(1)

Transparent = no_sprite
Channelb[0] = no_sound0
Channelb[1] = no_sound1
Channelb[2] = no_sound2
Channelb[3] = no_sound3
Channelb[4] = no_sound4
Channelb[5] = no_sound5
Channelb[6] = no_sound6
Channelb[7] = no_sound7
Channelb[8] = no_sound8
Channelb[9] = no_sound9

cam_deadzone_left = 600
cam_deadzone_right = 300

cam_deadzone_up = 400
cam_deadzone_down = 200

main_camera = camera_get_active()
cam_view_x = camera_get_view_x(main_camera)
cam_view_y = camera_get_view_y(main_camera)
cam_view_width = camera_get_view_width(main_camera)
cam_view_height = camera_get_view_height(main_camera)

last_pan_lerp_x = 0

areas = get_areas()
show_debug_message(areas)

for (numb = 0; numb < 9; numb += 1)
{
	Channel[numb] = Channelb[numb]
}
global.pan_x = true
global.pan_y = true

ImageLoaded = 0
currenttime = 0
hotspots_activate = 1
inittrans = 0
transdur2 = 0
transition = no_transition
transition_create = 0
draw_transition = 0
transition_alpha = 0
direction = 180
last_direction = direction
enablepanoramamode = 0
frame_haspanoramaprojection = 0
frame_maxhotspotcount = 0
over_hotspot = 0
over_counter = 0
over_counter2 = 0
mousex = window_mouse_get_x()
mousey = window_mouse_get_y()
createtimedevent = 0
frame_hastimedevent = 0
gotoframe1 = 0
gotoframe2 = 0
frame = 0
currentframe = 0
zdirection = 0
last_zdirection = zdirection
z = 0
nextcheck = 0
enableclick = 1
image_speed = 0.25
gametitle = 0
windowwidth = display_get_width()
windowheight = display_get_height()
initwindow = 0
mouse_lock_init()
ini_open(working_directory + "/run.ini")
gametitle = ini_read_string("gamesettings", "gametitle", "")
startarea = ini_read_string("gamesettings", "startarea", "")

area_config_file = file_text_open_read("areas/" + startarea + "/config.json")
area_file_content = ""

while(!file_text_eof(area_config_file))
{
   area_file_content += file_text_read_string(area_config_file);
   file_text_readln(area_config_file);
}
file_text_close(area_config_file);

area_config = json_parse(area_file_content)

// show_debug_message(area_config)

startframe = ini_read_string("gamesettings", "startframe", "")
debug_game = ini_read_real("gamesettings", "debug_game", 0)
windowwidth = ini_read_real("gamesettings", "windowwidth", display_get_width())
windowheight = ini_read_real("gamesettings", "windowheight", display_get_height())
fullscreen = ini_read_real("gamesettings", "fullscreen", 0)
initwindow = !fullscreen
panoramaaspectratio = area_config.panorama_config.aspect_ratio
maxglobalindex = 0
while (ini_key_exists("gamesettings", "global_variable" + string(maxglobalindex)))
{
	global_variable[maxglobalindex] = ini_read_string("gamesettings", "global_variable" + string(maxglobalindex), "Default")
	maxglobalindex += 1
}
currentframe = startframe
previousframe = currentframe
ini_close()
generate_current_frame()
for (i = 0; i < frame_maxhotspotcount; i += 1)
{
	transdur1[i] = 0
}
calculate_direction()
ini_open(working_directory + "/run.ini")
direction = area_config.panorama_config.start_direction[0]
zdirection = area_config.panorama_config.start_direction[1] * MaximumVerticalAngle
ini_close()
for (i = 0; i < frame_maxhotspotcount; i += 1)
{
	for (varindex = 0; varindex <= variable_maxvariablecount[i]; varindex += 1)
	{
		variable_set_value[i, varindex] = 0
	}
}
window_set_caption(gametitle)
window_set_fullscreen(fullscreen)
if (fullscreen = 0)
{
	window_set_rectangle((display_get_width() / 2) - (windowwidth / 2), (display_get_height() / 2) - (windowheight / 2), windowwidth, windowheight)
}
