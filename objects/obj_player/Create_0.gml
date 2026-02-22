facing_direction = FACING.DOWN;
next_image_index = undefined;
anim_flag = false;
auto_move_timer = 0;

function set_animation_alarm() {
	alarm[0] = 8;
	anim_flag = !anim_flag;
}

function move(_direction, _tiles) {
	var _event_tilemap = get_event_tilemap();
	var _current_tile_event = tilemap_get_at_pixel(_event_tilemap, x, y);
	var _nx = x + struct_get(VECTORS[_direction], "x") * _tiles * TILE_SIZE;
	var _ny = y + struct_get(VECTORS[_direction], "y") * _tiles * TILE_SIZE;
	var _target_tile_event = tilemap_get_at_pixel(_event_tilemap, _nx, _ny);

	if (_target_tile_event != EVENT.WALL) {
		x = _nx;
		y = _ny;
	}
	if (_target_tile_event == EVENT.DOOR) {
		set_active_plane(
			state.player_active_plane == PLANE.INTERIOR ? PLANE.EXTERIOR : PLANE.INTERIOR
		);
	}

	tick();
}

function interact() {
	var _event_tilemap = get_event_tilemap();
	var _tx = x + struct_get(VECTORS[facing_direction], "x") * TILE_SIZE;
	var _ty = y + struct_get(VECTORS[facing_direction], "y") * TILE_SIZE;
	var _target_tile_event = tilemap_get_at_pixel(_event_tilemap, _tx, _ty);
    log(_target_tile_event);
    tick();
}

function get_event_tilemap() {
    return layer_tilemap_get_id(EVENT_LAYERS[state.player_active_plane]);
}
