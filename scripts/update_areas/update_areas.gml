// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_areas() {
	area = 0
	var area_folder = working_directory + "/areas"
	
	files[area] = file_find_first(working_directory + "/areas/*", fa_directory);
	for (area = 1; file_find_next() != ""; ++area) {
		files[area] = file_find_next();
	}
	
	return files
}