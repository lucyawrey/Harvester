#macro log show_debug_message

function get_actor(_tx, _ty, _ignore_obj_id = undefined) {
	with (obj_actor) {
		if (tx == _tx && ty == _ty) {
			if (_ignore_obj_id != undefined && _ignore_obj_id == id) {
				continue;
			}
			return id;
		}
	}
	return noone;
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
