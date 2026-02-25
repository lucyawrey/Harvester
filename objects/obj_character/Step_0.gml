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
