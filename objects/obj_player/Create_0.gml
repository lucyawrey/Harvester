facing_direction = FACING.DOWN;
next_image_index = undefined;
anim_flag = false;

function set_animation_alarm() {
	alarm[0] = 10;
	anim_flag = !anim_flag;
}

function move(_direction, _tiles) {
    x += struct_get(VECTORS[_direction], "x") * _tiles * TILE_SIZE;
    y += struct_get(VECTORS[_direction], "y") * _tiles * TILE_SIZE;
}
