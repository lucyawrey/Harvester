// Config
is_solid = false;
z_order = 0

// State
// TODO handle scaling and angle+facing
tx = tilemap_get_cell_x_at_pixel(get_tilemap_1(), x, y);
ty = tilemap_get_cell_y_at_pixel(get_tilemap_1(), x, y);

function on_interact() {}

function on_enter() {}

function get_tilemap_1() {
	return layer_tilemap_get_id(PLANES[current_plane][0]);
}

function get_tilemap_2() {
	return layer_tilemap_get_id(PLANES[current_plane][1]);
}
