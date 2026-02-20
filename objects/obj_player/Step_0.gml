if (InputCheck(VERB.DOWN) && auto_move_timer == 0) {
	move(FACING.DOWN, 1);
	image_index = anim_flag ? SPRITE.DOWN_WALK_2 : SPRITE.DOWN_WALK_1;
	next_image_index = SPRITE.DOWN;
	facing_direction = FACING.DOWN;
	set_animation_alarm();
} else if (InputCheck(VERB.LEFT) && auto_move_timer == 0) {
	move(FACING.LEFT, 1);
	image_index = anim_flag ? SPRITE.LEFT_WALK_2 : SPRITE.LEFT_WALK_1;
	next_image_index = SPRITE.LEFT;
	facing_direction = FACING.LEFT;
	set_animation_alarm();
} else if (InputCheck(VERB.RIGHT) && auto_move_timer == 0) {
	move(FACING.RIGHT, 1);
	image_index = anim_flag ? SPRITE.RIGHT_WALK_2 : SPRITE.RIGHT_WALK_1;
	next_image_index = SPRITE.RIGHT;
	facing_direction = FACING.RIGHT;
	set_animation_alarm();
} else if (InputCheck(VERB.UP) && auto_move_timer == 0) {
	move(FACING.UP, 1);
	image_index = anim_flag ? SPRITE.UP_WALK_2 : SPRITE.UP_WALK_1;
	next_image_index = SPRITE.UP;
	facing_direction = FACING.UP;
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
