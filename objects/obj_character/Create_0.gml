// Config
is_player = false;
base_move_speed = 1;
image_index = SPRITE.DOWN;

// State
current_plane = get_plane_from_layer(layer);
move_speed = base_move_speed;
move_delay = TILE_SIZE / move_speed;
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
	var _tx = tx + struct_get(VECTORS[facing_direction], "x") * _tiles * TILE_SIZE;
	var _ty = ty + struct_get(VECTORS[facing_direction], "y") * _tiles * TILE_SIZE;
	var _target_tile_event = tilemap_get_at_pixel(get_event_tilemap(), _tx, _ty);

	var _target_character = instance_position(_tx, _ty, obj_character);

	// TODO check collision based on future target character position
	if (_target_tile_event != EVENT.WALL && _target_character == noone) {
		tx = _tx;
		ty = _ty;
	}
	if (_target_tile_event == EVENT.DOOR) {
		queue_door = true;
	}
	is_moving = true;

	target_image_index = _direction * 3 + 1;
	image_index = target_image_index + (animation_toggle ? 1 : -1);
	animation_toggle = !animation_toggle;

	if (is_player) {
		tick();
	}
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
		instance_create_layer(_tx, _ty, get_object_layer(), obj_crop);
	}
	var _item = try_collect_item(_tx, _ty);
	if (!_item && _target_crop != noone) {
		_target_crop.interact();
	}

	if (is_player) {
		tick();
	}
}

function arrive() {
	if (queue_interact) {
		queue_interact = false;
		interact();
	}
	if (queue_door) {
		switch_plane();
		queue_door = false;
	}
	try_collect_item(x, y);
}

function switch_plane() {
	var _new_plane = current_plane == PLANE.INTERIOR ? PLANE.EXTERIOR : PLANE.INTERIOR;
	layer = get_object_layer_id(_new_plane);
	current_plane = _new_plane;
	if (is_player) {
		set_active_plane(_new_plane);
	}
}

function get_event_tilemap() {
	return layer_tilemap_get_id(EVENT_LAYERS[current_plane]);
}

function get_2_tilemap() {
	return layer_tilemap_get_id(LAYERS_2[current_plane]);
}

function get_object_layer() {
	return layer_get_id(OBJECT_LAYERS[current_plane]);
}
