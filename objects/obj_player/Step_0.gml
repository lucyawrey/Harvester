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
	if (InputPressed(VERB.ACCEPT)) {
		interact();
	}
}

// Camera
camera_set_view_pos(
	camera,
	x - (VIEW_WIDTH - TILE_SIZE) / 2,
	y - (VIEW_HEIGHT - TILE_SIZE) / 2
);
