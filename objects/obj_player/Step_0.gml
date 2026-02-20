// TODO better analogue input handling
if (InputPressed(VERB.DOWN)) {
	y += TILE_SIZE;
	image_index = anim_flag ? SPRITE.DOWN_WALK_2 : SPRITE.DOWN_WALK_1;
	next_image_index = SPRITE.DOWN;
	facing_direction = VERB.DOWN;
	set_animation_alarm();
} else if (InputPressed(VERB.LEFT)) {
	x -= TILE_SIZE;
	image_index = anim_flag ? SPRITE.LEFT_WALK_2 : SPRITE.LEFT_WALK_1;
	next_image_index = SPRITE.LEFT;
	facing_direction = VERB.LEFT;
	set_animation_alarm();
} else if (InputPressed(VERB.RIGHT)) {
	x += TILE_SIZE;
	image_index = anim_flag ? SPRITE.RIGHT_WALK_2 : SPRITE.RIGHT_WALK_1;
	next_image_index = SPRITE.RIGHT;
	facing_direction = VERB.RIGHT;
	set_animation_alarm();
} else if (InputPressed(VERB.UP)) {
	y -= TILE_SIZE;
	image_index = anim_flag ? SPRITE.UP_WALK_2 : SPRITE.UP_WALK_1;
	next_image_index = SPRITE.UP;
	facing_direction = VERB.UP;
	set_animation_alarm();
}
