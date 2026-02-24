if (!is_moving) {
	// Input
	if (InputCheck(VERB.DOWN)) {
		move(FACING.DOWN, 1);
		image_index = animation_toggle ? SPRITE.DOWN_WALK_2 : SPRITE.DOWN_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.DOWN;
	} else if (InputCheck(VERB.LEFT)) {
		move(FACING.LEFT, 1);
		image_index = animation_toggle ? SPRITE.LEFT_WALK_2 : SPRITE.LEFT_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.LEFT;
	} else if (InputCheck(VERB.RIGHT)) {
		move(FACING.RIGHT, 1);
		image_index = animation_toggle ? SPRITE.RIGHT_WALK_2 : SPRITE.RIGHT_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.RIGHT;
	} else if (InputCheck(VERB.UP)) {
		move(FACING.UP, 1);
		image_index = animation_toggle ? SPRITE.UP_WALK_2 : SPRITE.UP_WALK_1;
		animation_toggle = !animation_toggle;
		target_image_index = SPRITE.UP;
	}
    if (InputPressed(VERB.ACCEPT)) {
		interact();
	}
} else {
	// Movement
	if (move_timer < move_delay / 2) {
        if (InputCheck(VERB.ACCEPT)) {
            queue_interact = true;
        }
		image_index = target_image_index;
	}
    
	if (x != tx || y != ty || move_timer > 0) {
		x = x + sign(tx - x) * move_speed;
		y = y + sign(ty - y) * move_speed;

		if (abs(tx - x) < move_speed) {
			x = tx;
		}
		if (abs(ty - y) < move_speed) {
			y = ty;
		}
	} else {
        if (queue_interact) {
            queue_interact = false;
            interact();
        }
		is_moving = false;
	}
	move_timer--;
}
