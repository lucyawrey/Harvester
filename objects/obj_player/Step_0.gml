// Sprint check
move_speed = InputCheck(VERB.CANCEL) ? base_move_speed * 2 : base_move_speed;
move_delay = TILE_SIZE / move_speed;

if (is_moving) {
	if (move_timer > move_delay / 2) {
		if (InputCheck(VERB.ACCEPT)) {
			queue_interact = true;
		}
		image_index = target_image_index;
	}

	if (x != tx || y != ty || move_timer < move_delay) {
		x = x + sign(tx - x) * move_speed;
		y = y + sign(ty - y) * move_speed;

		if (abs(tx - x) < move_speed) {
			x = tx;
		}
		if (abs(ty - y) < move_speed) {
			y = ty;
		}
	} else {
		x = tx;
		y = ty;
        is_moving = false;
        move_timer = 0;
		arrive();
	}

	move_timer++;
}

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
