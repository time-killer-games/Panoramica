//Create timed event
if (draw_transition = 0)
{
	createtimedevent = frame_hastimedevent
	if (createtimedevent = 1)
	{
		currenttime += 0.01
		if (currenttime >= frame_timedeventtotaltime)
		{
			gotoframe2 = frame_hastimedevent
		}
	}
}

//Go to a different frame (timed event)
if (draw_transition = 0)
{
	if (gotoframe2 = 1)
	{
		if (currentframe != frame_timedeventdestinationframe)
		{
			hotspots_activate = 0
			transition_create = 1
			draw_transition = 1
			if (enabletransition2 = 1)
			{
				transition_alpha = 1
			} 
			else 
			{
				transitionduration2 = 0
				transition_alpha = 0
			}
			for (i = 0; i < frame_maxhotspotcount; i += 1)
			{
				messageduration[i] = 0
				showmessage[i] = 0
			}
			inittrans = 1
			previousframe = currentframe
			prevframe_maxhotspotcount = frame_maxhotspotcount
			currentframe = frame_timedeventdestinationframe
			currenttime = 0
			gotoframe2 = 0
		}
	}
}

//Detect mouse hover over hotspot
if (draw_transition = 0 && ImageLoaded = 1)
{
	for (i = 0; i < frame_maxhotspotcount; i += 1)
	{
		variable_enable_hotspot[i] = 1
		for (globalindex = 0; globalindex < maxglobalindex; globalindex += 1)
		{
			for (varindex = 0; varindex <= variable_maxvariablecount[i]; varindex += 1)
			{
				if (global_variable[globalindex] = variable_name[i, varindex])
				{
					if (variable_get[i, varindex] = 1)
					{
						if (variable_get_value[i, varindex] = variable_set_value[i, varindex])
						{
							variable_enable_hotspot[i] = 1
						}
						else 
						{
							variable_enable_hotspot[i] = 0 
						}
					}
				}
			}
		}
		if (mousex >= real(left[i]) && mousey >= real(top[i]) && mousex <= real(left[i]) + real(width[i]) && mousey <= real(top[i]) + real(height[i]) && variable_enable_hotspot[i] = 1)
		{
			over_counter += 1
			over_hotspot = 1
		}
		if (mousex >= real(left[i]) && mousey >= real(top[i]) && mousex <= real(left[i]) + real(width[i]) && mousey <= real(top[i]) + real(height[i]) && variable_enable_hotspot[i] = 1)
		{
			over_counter2 += 1
		}
		if (over_counter2 = 0)
		{
			while (over_counter > 0)
			{
				over_counter -= 1
			}
			over_hotspot = 0
		}
	}
	over_counter2 = 0
}

//Detect the specific hotspot clicked
if (enablepanoramamode = 0 || mouse_is_locked() = 1)
{
	if (draw_transition = 0 && ImageLoaded = 1)
	{
		if (hotspots_activate = 1)
		{
			for (i = 0; i < frame_maxhotspotcount; i += 1)
			{
				if (enableclick = 1)
				{
					if (mouse_check_button_pressed(mb_left))
					{
						if (mousex >= real(left[i]) && mousey >= real(top[i]) && mousex <= real(left[i]) + real(width[i]) && mousey <= real(top[i]) + real(height[i]) && variable_enable_hotspot[i] = 1)
						{
							clicked[i] = 1
							for (globalindex = 0; globalindex < maxglobalindex; globalindex += 1)
							{
								for (varindex = 0; varindex <= variable_maxvariablecount[i]; varindex += 1)
								{
									if (global_variable[globalindex] = variable_name[i, varindex])
									{
										if (variable_set[i, varindex] = 1)
										{
											ini_open(working_directory + "/run.ini")
											variable_set_value[i, varindex] = ini_read_real(string(currentframe) + "-hotspot" + string(i) + "-variable" + string(varindex), "variable_set_value", 0)
											ini_close()
										}
									}
								}
							}
							if (gotoframe1[i] = 1)
							{
								if (currentframe != frame[i])
								{
									transition_create = 1
									draw_transition = 1
									if (enabletransition1[i] = 1)
									{
										transition_alpha = 1
									}
									else 
									{
										transitionduration1[i] = 0
										transition_alpha = 0
									}
									messageduration[i] = 0
									showmessage[i] = 0
									inittrans = 1
									previousframe = currentframe
									prevframe_maxhotspotcount = frame_maxhotspotcount
									currentframe = frame[i]
								}
							}
							else 
							{
								ini_open(working_directory + "/run.ini")
								showmessage[i] = ini_read_real(string(currentframe) + "-hotspot" + string(i), "hotspot_mustshowmessage", 0)
								messageduration[i] = (string_length(messagetext[i]) * 0.075)
								ini_close()
							}
						}
						else 
						{ 
							clicked[i] = 0 
						}
						nextcheck = 1
					}
				}
			}
		}
	}
}

//Transition Closing
if (draw_transition = 1)
{
	image_speed = 0
	if (hotspots_activate = 1)
	{
		if (inittrans = 1)
		{
			for (i = 0; i < frame_maxhotspotcount; i += 1)
			{
				transdur1[i] = transitionduration1[i]
			}
			inittrans = 0
		}
		else
		{
			for (i = 0; i < prevframe_maxhotspotcount; i += 1)
			{
				transition_alpha -= transdur1[i] / 100
			}
		}
	}
	if (hotspots_activate = 0)
	{
		if (inittrans = 1)
		{
			transdur2 = transitionduration2
			inittrans = 0
		}
		else 
		{ 
			transition_alpha -= transdur2 * 0.01
		}
	}
	if (transition_alpha <= 0)
	{
		if (sprite_exists(transition))
		{
			sprite_delete(transition)
			transition = no_transition
		}
		if (file_exists(working_directory + "/transition.png"))
		{
			file_delete(working_directory + "/transition.png")
		}
		draw_transition = 0
		transition_alpha = 0
		hotspots_activate = 1
		for (i = 0; i < prevframe_maxhotspotcount; i += 1)
		{
			transdur1[i] = 0
		}
		transdur2 = 0
	}
}
else 
{ 
	image_speed = 0.25 
}
if (image_index >= frame_background_imgnumb)
{
	image_index = 0
}

//Message closing
if (nextcheck = 1)
{
	message_enabled = 0
	for (i = 0; i < frame_maxhotspotcount; i += 1)
	{
		if (showmessage[i] = 1)
		{
			messageduration[i] -= .01
			if (window_mouse_get_x() >= 0 && window_mouse_get_x() <= window_get_width()) && 
			(window_mouse_get_y() >= window_get_height() - (string_height(messagetext[i]) / 1.5) &&
			window_mouse_get_y() <= window_get_height())
			{
				enableclick = 0
				if (mouse_check_button_pressed(mb_left))
				{
					showmessage[i] = 0
					messageduration[i] = 0
					nextcheck = 0
					enableclick = 1
					message_enabled = 0
				}
			}
			else 
			{ 
				enableclick = 1 
			}
			if (messageduration[i] <= 0)
			{
				showmessage[i] = 0
				nextcheck = 0
				enableclick = 1
				message_enabled = 0
			}
		}
	}
}

//Delete sounds no longer used (GameMaker Studio 1.x and GameMaker Studio 2.x)
for (numb = 0; numb < 9; numb += 1)
{
	if (audio_exists(Channel[numb]))
	{
		if (Channel[numb] != Channelb[numb])
		{
			if (!audio_is_playing(Channel[numb]))
			{
				audio_destroy_stream(Channel[numb])
			}
		}
	}
}

//Resize Application Surface (GameMaker Studio 1.x and GameMaker Studio 2.x)
if (window_has_focus() = 1)
{
	surface_resize(application_surface, window_get_width(), window_get_height())
}
