event_inherited();

// Config
is_solid = true;
z_order = 1;
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
inventory = array_create(INVENTORY_SLOTS, undefined);
inventory_selection = 1;

function move(_direction, _tiles) {
	if (_tiles == 0) {
		return;
	}
	facing_direction = _direction;
	var _ntx = tx + struct_get(VECTORS[facing_direction], "x") * _tiles;
	var _nty = ty + struct_get(VECTORS[facing_direction], "y") * _tiles;
	var _current_tile_1 = tilemap_get_tile(get_tilemap_1(), tx, ty);
	var _current_tile_2 = tilemap_get_tile(get_tilemap_2(), tx, ty);
	var _target_tile_1 = tilemap_get_tile(get_tilemap_1(), _ntx, _nty);
	var _target_tile_2 = tilemap_get_tile(get_tilemap_2(), _ntx, _nty);
	var _target_actor = get_actor(_ntx, _nty, current_plane);

	if (
		!_target_tile_1.is_solid
		&& !_target_tile_2.is_solid
		&& (_target_actor == noone || !_target_actor.is_solid)
	) {
		tx = _ntx;
		ty = _nty;
	}
	if (_target_tile_2.enter == "door") {
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
	var _target_tile_1 = tilemap_get_tile(get_tilemap_1(), _ntx, _nty);
	var _target_tile_2 = tilemap_get_tile(get_tilemap_2(), _ntx, _nty);
	var _target_actor = get_actor(_ntx, _nty, current_plane);

	if (_target_tile_1.is_soil && _target_tile_2.name == "void" && _target_actor == noone) {
		tilemap_set(get_tilemap_2(), tile_get_id("tilled"), _ntx, _nty);
		if (is_player) {
			energy_spend();
		}
	}

	if (_target_tile_2.name == "tilled" && _target_actor == noone) {
		create_actor(_ntx, _nty, z_order, current_plane, obj_crop);
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

	var _target_actor = get_actor(tx, ty, current_plane, id);
	if (_target_actor != noone) {
		_target_actor.on_enter();
	}
}

function switch_plane() {
	var _new_plane = current_plane == PLANE.INTERIOR ? PLANE.EXTERIOR : PLANE.INTERIOR;
	current_plane = _new_plane;
	if (is_player) {
		set_active_plane(_new_plane);
	}
}

function add_item(_id, _quantity = 1) {
    // TODO handle item stacking
    var _position = get_free_slot(inventory, inventory_selection - 1, 1);
    log(_position);
    if (_position != -1) {
        inventory[_position - 1] = {id: _id, quantity: _quantity};
    }
    return false;
}
