event_inherited();

if (!is_moving) {
	if (InputY(CLUSTER.NAVIGATION) > DEADZONE) {
		move(FACING.DOWN, 1);
		image_index = animation_toggle ? SPRITE.DOWN_WALK_2 : SPRITE.DOWN_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.DOWN;
	} else if (InputX(CLUSTER.NAVIGATION) < -DEADZONE) {
		move(FACING.LEFT, 1);
		image_index = animation_toggle ? SPRITE.LEFT_WALK_2 : SPRITE.LEFT_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.LEFT;
	} else if (InputX(CLUSTER.NAVIGATION) > DEADZONE) {
		move(FACING.RIGHT, 1);
		image_index = animation_toggle ? SPRITE.RIGHT_WALK_2 : SPRITE.RIGHT_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.RIGHT;
	} else if (InputY(CLUSTER.NAVIGATION) < -DEADZONE) {
		move(FACING.UP, 1);
		image_index = animation_toggle ? SPRITE.UP_WALK_2 : SPRITE.UP_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.UP;
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
