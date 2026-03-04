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
    var _new = instance_create_layer(pixel(_tx), pixel(_ty), "Actor", _object_id);
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
