// Config
is_solid = false;

// State
current_plane = get_plane_from_layer(layer);
tx = tilemap_get_cell_x_at_pixel(get_event_tilemap(), x, y);
ty = tilemap_get_cell_y_at_pixel(get_event_tilemap(), x, y);

function on_interact() {}

function on_intersect() {}

function get_actor_layer() {
	return layer_get_id(ACTOR_LAYERS[current_plane]);
}

function get_event_tilemap() {
	return layer_tilemap_get_id(EVENT_LAYERS[current_plane]);
}

function get_1_tilemap() {
	return layer_tilemap_get_id(LAYERS_1[current_plane]);
}

function get_2_tilemap() {
	return layer_tilemap_get_id(LAYERS_2[current_plane]);
}
