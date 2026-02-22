if (InputCheck(VERB.DOWN) && auto_move_timer == 0) {
	move(FACING.DOWN, 1);
	image_index = anim_flag ? SPRITE.DOWN_WALK_2 : SPRITE.DOWN_WALK_1;
	next_image_index = SPRITE.DOWN;

	set_animation_alarm();
} else if (InputCheck(VERB.LEFT) && auto_move_timer == 0) {
	move(FACING.LEFT, 1);
	image_index = anim_flag ? SPRITE.LEFT_WALK_2 : SPRITE.LEFT_WALK_1;
	next_image_index = SPRITE.LEFT;
	set_animation_alarm();
} else if (InputCheck(VERB.RIGHT) && auto_move_timer == 0) {
	move(FACING.RIGHT, 1);
	image_index = anim_flag ? SPRITE.RIGHT_WALK_2 : SPRITE.RIGHT_WALK_1;
	next_image_index = SPRITE.RIGHT;
	set_animation_alarm();
} else if (InputCheck(VERB.UP) && auto_move_timer == 0) {
	move(FACING.UP, 1);
	image_index = anim_flag ? SPRITE.UP_WALK_2 : SPRITE.UP_WALK_1;
	next_image_index = SPRITE.UP;
	set_animation_alarm();
}

if (InputCheckMany([VERB.DOWN, VERB.LEFT, VERB.RIGHT, VERB.UP])) {
	if (auto_move_timer >= AUTO_MOVE_DELAY) {
		auto_move_timer = 0;
	} else {
		auto_move_timer++;
	}
} else {
	auto_move_timer = 0;
}

if (InputPressed(VERB.ACCEPT)) {
	interact();
}

if (InputCheck(VERB.CANCEL)) {
	tick();
}
