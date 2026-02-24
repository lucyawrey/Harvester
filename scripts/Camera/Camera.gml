#macro TILE_SIZE 16
#macro VIEW_TILE_WIDTH 20
#macro VIEW_TILE_HEIGHT 12
#macro VIEW_WIDTH (VIEW_TILE_WIDTH * TILE_SIZE)
#macro VIEW_HEIGHT (VIEW_TILE_HEIGHT * TILE_SIZE)
#macro WINDOW_SCALE 3

#macro camera global.__camera

function setup_camera() {
	// Enable viewports
	view_enabled = true;
	view_set_visible(0, true);

	// Set viewport values
	view_set_xport(0, 0);
	view_set_yport(0, 0);
	view_set_wport(0, VIEW_WIDTH);
	view_set_hport(0, VIEW_HEIGHT);
	display_set_gui_size(VIEW_WIDTH, VIEW_HEIGHT);

	// Set camera values
	camera = camera_create_view(0, 0, VIEW_WIDTH, VIEW_HEIGHT, 0, -1, -1, -1, -1, -1);
	view_set_camera(0, camera);

	// Scale game window
	var _dwidth = display_get_width();
	var _dheight = display_get_height();
	var _wx = (_dwidth / 2) - (VIEW_WIDTH * WINDOW_SCALE / 2);
	var _wy = (_dheight / 2) - (VIEW_HEIGHT * WINDOW_SCALE / 2);
	window_set_rectangle(_wx, _wy, VIEW_WIDTH * WINDOW_SCALE, VIEW_HEIGHT * WINDOW_SCALE);
}
