// Config
growth_time_in_days = 3;
viable_seasons = [SEASON.SPRING, SEASON.SUMMER];

// State
current_plane = get_plane_from_layer(layer);
tx = tilemap_get_cell_x_at_pixel(get_event_tilemap(), x, y);
ty = tilemap_get_cell_y_at_pixel(get_event_tilemap(), x, y);
current_growth_stage = 1;

function grow() {
	if (current_growth_stage < growth_time_in_days) {
		current_growth_stage++;
	}
	set_visual();
}

function set_visual() {
	image_index = (current_growth_stage / growth_time_in_days * VISUAL_GROWTH_STAGES) - 1;
}

function interact() {
	if (current_growth_stage == growth_time_in_days) {
		instance_destroy();
		instance_create_layer(x + 1, y + 1, layer, obj_item);
	}
}

function get_event_tilemap() {
	return layer_tilemap_get_id(EVENT_LAYERS[current_plane]);
}
