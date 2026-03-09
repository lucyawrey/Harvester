#macro log show_debug_message

function get_actor(_tx, _ty, _plane, _ignore_obj_id = undefined) {
	with (obj_actor) {
		if (tx == _tx && ty == _ty) {
			if (
				current_plane != _plane
				|| (_ignore_obj_id != undefined && _ignore_obj_id == id)
			) {
				continue;
			}
			return id;
		}
	}
	return noone;
}

function create_actor(_tx, _ty, _plane, _object_id) {
	var _new = instance_create_layer(
		pixel(_tx),
		pixel(_ty) + TILE_SIZE,
		"Actor",
		_object_id
	);
	_new.tx = _tx;
	_new.ty = _ty;
	_new.current_plane = _plane;
}

function struct_get_merged(_structs, _name) {
	for (var _i = array_length(_structs) - 1; _i >= 0; _i--) {
		var _item = _structs[_i];
		if (is_undefined(_item)) {
			continue;
		}
		if (is_string(_item) || is_bool(_item) || is_real(_item)) {
			return _item;
		}
		if (struct_exists(_item, _name)) {
			return struct_get(_item, _name);
		}
		if (struct_exists(_item, _name + ":")) {
			return struct_get(_item, _name + ":");
		}
	}
}

function struct_merge(_destination, _source) {
	if (!is_struct(_destination) || !is_struct(_source)) {
		return;
	}
	destination_ = _destination;
	struct_foreach(_source, function(_name, _value) {
		struct_set(destination_, _name, _value);
	});
}

function get_offset_for_rotation(_sprite, _angle, _scale = 2) {
	var _w = sprite_get_width(_sprite) * _scale;
	var _h = sprite_get_height(_sprite) * _scale;

	return {
		x: sqrt(power(_w, 2) + power(_h, 2)) / 2 * dcos(-_angle + darctan(_h / _w)),
		y: sqrt(power(_w, 2) + power(_h, 2)) / 2 * dsin(-_angle + darctan(_h / _w)),
	};
}
