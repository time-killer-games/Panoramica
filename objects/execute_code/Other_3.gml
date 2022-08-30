//Unload resources (GameMaker Studio 1.x and GameMaker Studio 2.x)
if (sprite_exists(Transparent)) 
{ 
	sprite_delete(Transparent) 
}
if (sprite_exists(transition)) 
{ 
	sprite_delete(transition) 
}
if (file_exists(working_directory + "/transition.png"))
{
	file_delete(working_directory + "/transition.png")
}
for (numb = 0; numb < 9; numb += 1)
{
	if (audio_is_playing(Channel[numb])) 
	{ 
		audio_stop_sound(Channel[numb]) 
	}
	if (audio_exists(Channel[numb]) && Channel[numb] != Channelb[numb])
	{
		audio_destroy_stream(Channel[numb])
	}
}
d3d_end()
