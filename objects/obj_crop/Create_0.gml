event_inherited();

// Config
growth_time_in_days = 4;
viable_seasons = [SEASON.SPRING, SEASON.SUMMER];
is_solid_stage = 3;
visual_growth_stages = 4;

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
	image_index = (current_growth_stage / growth_time_in_days * visual_growth_stages) - 1;
}

function on_interact() {
	if (current_growth_stage == growth_time_in_days) {
		create_actor(tx, ty, z_order, current_plane, obj_item);
		instance_destroy();
	}
}
