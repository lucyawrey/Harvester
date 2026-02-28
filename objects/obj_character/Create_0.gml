event_inherited();

// Config
is_solid = true;
is_player = false;
base_move_speed = 1;
image_index = SPRITE.DOWN;

// State
is_moving = false;
facing_direction = FACING.DOWN;
move_speed = base_move_speed;
move_delay = TILE_SIZE / move_speed;
target_image_index = SPRITE.DOWN;
animation_toggle = false;
move_timer = 0;
queue_interact = false;
queue_door = false;

function move(_direction, _tiles) {
	facing_direction = _direction;
	var _current_tile_event = tilemap_get_at_pixel(get_event_tilemap(), x, y);
	var _ntx = tx + struct_get(VECTORS[facing_direction], "x") * _tiles;
	var _nty = ty + struct_get(VECTORS[facing_direction], "y") * _tiles;
	var _target_tile_event = tilemap_get(get_event_tilemap(), _ntx, _nty);
    // TODO only get actors on same plane
	var _target_actor = get_actor(_ntx, _nty);

	if (
		_target_tile_event != EVENT.WALL
		&& (_target_actor == noone || !_target_actor.is_solid)
	) {
		tx = _ntx;
		ty = _nty;
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
		energy_spend();
	}
}

function interact() {
	var _ntx = tx + struct_get(VECTORS[facing_direction], "x");
	var _nty = ty + struct_get(VECTORS[facing_direction], "y");
	var _target_tile_event = tilemap_get(get_event_tilemap(), _ntx, _nty);
	var _target_actor = get_actor(_ntx, _nty);

	if (_target_tile_event == EVENT.SOIL && _target_actor == noone) {
		tilemap_set(get_event_tilemap(), EVENT.TILLED, _ntx, _nty);
		tilemap_set(get_2_tilemap(), TILE.TILLED, _ntx, _nty);
		if (is_player) {
			energy_spend();
		}
	}

	if (_target_tile_event == EVENT.TILLED && _target_actor == noone) {
		instance_create_layer(pixel(_ntx), pixel(_nty), get_actor_layer(), obj_crop);
		if (is_player) {
			energy_spend();
		}
	}
	if (_target_actor != noone) {
		_target_actor.on_interact();
		if (is_player) {
			energy_spend();
		}
	}

	if (is_player) {
		tick();
		energy_spend();
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

	var _target_actor = get_actor(tx, ty, id);
	if (_target_actor != noone) {
		_target_actor.on_intersect();
	}
}

function switch_plane() {
	var _new_plane = current_plane == PLANE.INTERIOR ? PLANE.EXTERIOR : PLANE.INTERIOR;
	layer = get_actor_layer_id(_new_plane);
	current_plane = _new_plane;
	if (is_player) {
		set_active_plane(_new_plane);
	}
}
