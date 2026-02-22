// Crop config
growth_time_in_days = 3;
viable_seasons = [SEASON.SPRING, SEASON.SUMMER];

// Crop state
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
