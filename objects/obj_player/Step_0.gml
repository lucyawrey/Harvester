event_inherited();

if (!is_moving) {
	if (InputY(CLUSTER.NAVIGATION) > DEADZONE) {
		move(FACING.DOWN, 1);
	} else if (InputX(CLUSTER.NAVIGATION) < -DEADZONE) {
		move(FACING.LEFT, 1);
	} else if (InputX(CLUSTER.NAVIGATION) > DEADZONE) {
		move(FACING.RIGHT, 1);
	} else if (InputY(CLUSTER.NAVIGATION) < -DEADZONE) {
		move(FACING.UP, 1);
	}
	if (InputPressed(VERB.ACCEPT) && !obj_dialogue.visible) {
		interact();
	}
} else if (move_timer > move_delay / 2) {
	if (InputCheck(VERB.ACCEPT) && !obj_dialogue.visible) {
		queue_interact = true;
	}
}

if (InputPressed(VERB.CYCLE_BACK)) {
	var _slot = get_slot(inventory, inventory_selection, -1);
	if (is_struct(_slot)) {
		inventory_selection = _slot.position;
	}
}
if (InputPressed(VERB.CYCLE_FORWARD)) {
	var _slot = get_slot(inventory, inventory_selection, 1);
	if (is_struct(_slot)) {
		inventory_selection = _slot.position;
	}
}

// Camera
camera_set_view_pos(
	camera,
	x - (VIEW_WIDTH - TILE_SIZE) / 2,
	y - (VIEW_HEIGHT - TILE_SIZE) / 2
);
