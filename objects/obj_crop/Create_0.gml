event_inherited();

// Config
growth_time_in_days = 3;
viable_seasons = [SEASON.SPRING, SEASON.SUMMER];
is_solid_stage = 2;

// State
current_growth_stage = 1;

function grow() {
	if (current_growth_stage < growth_time_in_days) {
		current_growth_stage++;
	}
	is_solid = current_growth_stage >= is_solid_stage;
	set_visual();
}

function set_visual() {
	image_index = (current_growth_stage / growth_time_in_days * VISUAL_GROWTH_STAGES) - 1;
}

function on_interact() {
	if (current_growth_stage == growth_time_in_days) {
		instance_destroy();
		create_actor(x, y, z_order, current_plane, obj_item);
	}
}
