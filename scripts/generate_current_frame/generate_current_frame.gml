function generate_current_frame() 
{
	inittrans = 0
	over_hotspot = 0
	if (os_browser = browser_not_a_browser)
	{
		ImageLoaded = 1
	}
	else 
	{ 
		ImageLoaded = 0 
	}
	ini_open(working_directory + "/run.ini")
	frame_stopsound_all = ini_read_real(string(currentframe), "frame_stopsound_all", 0)
	for (numb = 0; numb < 9; numb += 1)
	{
		if (frame_stopsound_all = 1)
		{
			if (audio_is_playing(Channel[numb])) 
			{ 
				audio_stop_sound(Channel[numb]) 
				if (audio_exists(Channel[numb])) 
				{ 
					audio_destroy_stream(Channel[numb]) 
				} 
			}
		}
		frame_stopsound_channel[numb] = ini_read_real(string(currentframe), "frame_stopsound_channel" + string(numb), 0)
		if (frame_stopsound_channel[numb] = 1 && audio_is_playing(Channel[numb]))
		{ 
			audio_stop_sound(Channel[numb]) 
			if (audio_exists(Channel[numb])) 
			{ 
				audio_destroy_stream(Channel[numb]) 
			} 
		}
		frame_playsound_channel[numb] = ini_read_string(string(currentframe), "frame_playsound_channel" + string(numb), "")
		frame_loopsound_channel[numb] = ini_read_real(string(currentframe), "frame_loopsound_channel" + string(numb), 0)
		if (file_exists(working_directory + "/" + frame_playsound_channel[numb]) && !audio_is_playing(Channel[numb])) 
		{ 
			if (audio_exists(Channel[numb])) 
			{ 
				audio_destroy_stream(Channel[numb]) 
			} 
			Channel[numb] = audio_create_stream(working_directory + "/" + frame_playsound_channel[numb]) 
		}
		if (Channel[numb] != Channelb[numb] && file_exists(working_directory + "/" + frame_playsound_channel[numb]) && !audio_is_playing(Channel[numb])) { 
			if (frame_loopsound_channel[numb] = 1) then audio_play_sound(Channel[numb], 0, 1) else audio_play_sound(Channel[numb], 0, 0) 
		}
	}
	frame_background_imgnumb = ini_read_real(currentframe, "frame_background_imgnumb", 1)
	frame_haspanoramaprojection = ini_read_real(string(currentframe), "frame_haspanoramaprojection", 0)
	frame_hastimedevent = ini_read_real(string(currentframe), "frame_hastimedevent", 0)
	frame_timedeventtotaltime = ini_read_real(string(currentframe), "frame_timedeventtotaltime", 4)
	enabletransition2 = ini_read_real(string(currentframe), "frame_timedeventenabletransition", 0)
	transitionduration2 = ini_read_real(string(currentframe), "frame_timedeventtransitionduration", 0.8)
	frame_timedeventdestinationframe = ini_read_string(currentframe, "frame_timedeventdestinationframe", "")
	frame_maxhotspotcount = 0
	while (ini_section_exists(string(currentframe) + "-hotspot" + string(frame_maxhotspotcount)))
	{
		frame_maxhotspotcount += 1
	}
	for (i = 0; i < frame_maxhotspotcount; i += 1)
	{
		variable_maxvariablecount[i] = 0
		while (ini_section_exists(string(currentframe) + "-hotspot" + string(frame_maxhotspotcount) + "-variable" + string(variable_maxvariablecount[i])))
		{
			variable_maxvariablecount[i] += 1
		}
		left[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_left", 0)
		top[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_top", 0)
		width[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_width", 0)
		height[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_height", 0)
		hotspot_stopsound_all[i] = ini_read_real(string(currentframe) + string("-hotspot") + string(i), "hotspot_stopsound_all", 0)
		for (numb = 0; numb < 9; numb += 1)
		{
			if (hotspot_stopsound_all[i] = 1)
			{
				if (audio_is_playing(Channel[numb])) { 
					audio_stop_sound(Channel[numb])
					if (audio_exists(Channel[numb])) { 
						audio_destroy_stream(Channel[numb]) 
					} 
				}
			}
			hotspot_stopsound_channel[i, numb] = ini_read_real(string(currentframe) + string("-hotspot") + string(i), "hotspot_stopsound_channel" + string(numb), 0)
			if (hotspot_stopsound_channel[i, numb] = 1 && audio_is_playing(Channel[numb])) 
			{ 
				audio_stop_sound(Channel[numb]) 
				if (audio_exists(Channel[numb])) 
				{ 
					audio_destroy_stream(Channel[numb]) 
				} 
			}
			hotspot_playsound_channel[i, numb] = ini_read_string(currentframe + string("-hotspot") + string(i), "hotspot_playsound_channel" + string(numb), "")
			hotspot_loopsound_channel[i, numb] = ini_read_real(string(currentframe) + string("-hotspot") + string(i), "hotspot_loopsound_channel" + string(numb), 0)
			if (file_exists(working_directory + "/" + hotspot_playsound_channel[i, numb]) && !audio_is_playing(Channel[numb])) 
			{ 
				if (audio_exists(Channel[numb])) 
				{ 
					audio_destroy_stream(Channel[numb]) 
				} 
				Channel[numb] = audio_create_stream(working_directory + "/" + hotspot_playsound_channel[i, numb]) 
			}
			if (Channel[numb] != Channelb[numb] && file_exists(working_directory + "/" + hotspot_playsound_channel[i, numb]) && !audio_is_playing(Channel[numb])) 
			{ 
				if (hotspot_loopsound_channel[i, numb] = 1) 
				{
					audio_play_sound(Channel[numb], 0, 1)
				}
				else
				{ 
					audio_play_sound(Channel[numb], 0, 0) 
				}
			}
		}
		gotoframe1[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_mustgotoframe", 0)
		enabletransition1[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_enabletransition", 0)
		transitionduration1[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_transitionduration", 0.8)
		frame[i] = ini_read_string(string(currentframe) + "-hotspot" + string(i), "hotspot_destinationframe", "")
		showmessage[i] = 0
		messagetext[i] = string_replace_all(ini_read_string(string(currentframe) + "-hotspot" + string(i), "hotspot_messagetext", ""), "#", "\#")
		messagetext[i] = string_replace_all(messagetext[i], "\n", "#")
		messageduration[i] = (string_length(messagetext[i]) * 0.075)
		for (varindex = 0; varindex <= variable_maxvariablecount[i]; varindex += 1)
		{
			variable_name[i, varindex] = ini_read_string(string(currentframe) + "-hotspot" + string(i) + "-variable" + string(varindex), "variable_name", "")
			variable_set[i, varindex] = ini_read_real(string(currentframe) + "-hotspot" + string(i) + "-variable" + string(varindex), "variable_set", 0)
			variable_get_value[i, varindex] = ini_read_real(string(currentframe) + "-hotspot" + string(i) + "-variable" + string(varindex), "variable_get_value", 0)
			variable_get[i, varindex] = ini_read_real(string(currentframe) + "-hotspot" + string(i) + "-variable" + string(varindex), "variable_get", 0)
		}
	}
	if (sprite_exists(Transparent)) 
	{ 
		sprite_delete(Transparent) 
	}
	if (file_exists(working_directory + "/" + string(currentframe)))
	{
		Transparent = sprite_add(working_directory + "/" + string(currentframe), frame_background_imgnumb, 0, 0, 0, 0)
		ImageWidth = sprite_get_width(Transparent)
		ImageHeight = sprite_get_height(Transparent)	
		sprite_index = Transparent
		for (subimg = 0; subimg <= frame_background_imgnumb; subimg += 1)
		{
			tex[subimg] = sprite_get_texture(Transparent, subimg)
		}
	}
	ini_close()
}
