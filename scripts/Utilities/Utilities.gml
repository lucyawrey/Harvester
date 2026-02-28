#macro log show_debug_message

function get_actor(_tx, _ty) {
	with (obj_actor) {
		if (tx == _tx && ty == _ty) {
			return id;
		}
	}
	return noone;
}
