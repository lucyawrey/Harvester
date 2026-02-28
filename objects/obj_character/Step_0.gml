// Sprint check
move_speed = InputCheck(VERB.CANCEL) ? base_move_speed * 2 : base_move_speed;
move_delay = TILE_SIZE / move_speed;

if (is_moving) {
	var _nx = pixel(tx), _ny = pixel(ty);

	if (move_timer > move_delay / 2) {
		image_index = target_image_index;
	}

	if (x != _nx || y != _ny || move_timer < move_delay) {
		x = x + sign(_nx - x) * move_speed;
		y = y + sign(_ny - y) * move_speed;

		if (abs(_nx - x) < move_speed) {
			x = _nx;
		}
		if (abs(_ny - y) < move_speed) {
			y = _ny;
		}
	} else {
		x = _nx;
		y = _ny;
		is_moving = false;
		move_timer = 0;
		arrive();
	}

	move_timer++;
}
