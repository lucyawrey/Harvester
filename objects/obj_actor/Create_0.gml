// Config
is_solid = false;

// State
current_plane = get_plane_from_layer(layer);
tx = tilemap_get_cell_x_at_pixel(get_tilemap_1(), x, y);
ty = tilemap_get_cell_y_at_pixel(get_tilemap_1(), x, y);

function on_interact() {}

function on_enter() {}

function get_actor_layer() {
	return layer_get_id(ACTOR_LAYERS[current_plane]);
}

function get_tilemap_1() {
	return layer_tilemap_get_id(LAYERS_1[current_plane]);
}

function get_tilemap_2() {
	return layer_tilemap_get_id(LAYERS_2[current_plane]);
}
