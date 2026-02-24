// Config
move_speed = 1;
move_delay = TILE_SIZE / move_speed;

// State
facing_direction = FACING.DOWN;
target_image_index = SPRITE.DOWN;
animation_toggle = false;
tx = x;
ty = y;
is_moving = false;
move_timer = 0;
queue_interact = false;
queue_door = false;

function move(_direction, _tiles) {
	facing_direction = _direction;
	var _current_tile_event = tilemap_get_at_pixel(get_event_tilemap(), x, y);
	var _nx = x + struct_get(VECTORS[facing_direction], "x") * _tiles * TILE_SIZE;
	var _ny = y + struct_get(VECTORS[facing_direction], "y") * _tiles * TILE_SIZE;
	var _target_tile_event = tilemap_get_at_pixel(get_event_tilemap(), _nx, _ny);

	if (_target_tile_event != EVENT.WALL) {
		tx = _nx;
		ty = _ny;
	}
    if (_target_tile_event == EVENT.DOOR) {
        queue_door = true;
    }
	is_moving = true;
	move_timer = move_delay;

	tick();
}

function interact() {
	var _tx = x + struct_get(VECTORS[facing_direction], "x") * TILE_SIZE;
	var _ty = y + struct_get(VECTORS[facing_direction], "y") * TILE_SIZE;
	var _target_tile_event = tilemap_get_at_pixel(get_event_tilemap(), _tx, _ty);

	if (_target_tile_event == EVENT.SOIL) {
		tilemap_set_at_pixel(get_event_tilemap(), EVENT.TILLED, _tx, _ty);
		tilemap_set_at_pixel(get_2_tilemap(), TILE.TILLED, _tx, _ty);
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

function arrive() {
    if (queue_interact) {
        queue_interact = false;
        interact();
    }
    if (queue_door) {
		set_active_plane(
			state.player_active_plane == PLANE.INTERIOR ? PLANE.EXTERIOR : PLANE.INTERIOR
		);
        queue_door = false;
	}
    try_collect_item(x, y);
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
