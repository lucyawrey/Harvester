facing_direction = FACING.DOWN;
next_image_index = undefined;
anim_flag = false;
auto_move_timer = 0;

function set_animation_alarm() {
	alarm[0] = 8;
	anim_flag = !anim_flag;
}

function move(_direction, _tiles) {
	facing_direction = _direction;
	var _event_tilemap = get_event_tilemap();
	var _current_tile_event = tilemap_get_at_pixel(_event_tilemap, x, y);
	var _nx = x + struct_get(VECTORS[facing_direction], "x") * _tiles * TILE_SIZE;
	var _ny = y + struct_get(VECTORS[facing_direction], "y") * _tiles * TILE_SIZE;
	var _target_tile_event = tilemap_get_at_pixel(_event_tilemap, _nx, _ny);

	if (_target_tile_event != EVENT.WALL) {
		x = _nx;
		y = _ny;
        try_collect_item(_nx, _ny);
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
	var _2_tilemap = get_2_tilemap();
	var _tx = x + struct_get(VECTORS[facing_direction], "x") * TILE_SIZE;
	var _ty = y + struct_get(VECTORS[facing_direction], "y") * TILE_SIZE;
	var _target_tile_event = tilemap_get_at_pixel(_event_tilemap, _tx, _ty);

	if (_target_tile_event == EVENT.SOIL) {
		tilemap_set_at_pixel(_event_tilemap, EVENT.TILLED, _tx, _ty);
		tilemap_set_at_pixel(_2_tilemap, TILE.TILLED, _tx, _ty);
	}

	var _target_crop = instance_position(_tx, _ty, obj_crop);
	if (_target_tile_event == EVENT.TILLED && _target_crop == noone) {
		// TODO prevent infinite planting
		instance_create_layer(_tx, _ty, get_object_layer(), obj_crop);
	}
    var _item = try_collect_item(_tx, _ty);
	if (!_item && _target_crop != noone) {
		_target_crop.interact();
	}

	tick();
}

function get_event_tilemap() {
	return layer_tilemap_get_id(EVENT_LAYERS[state.player_active_plane]);
}

function get_2_tilemap() {
	return layer_tilemap_get_id(LAYERS_2[state.player_active_plane]);
}

function get_object_layer() {
	return layer_get_id(OBJECT_LAYERS[state.player_active_plane]);
}
