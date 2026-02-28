#macro log show_debug_message

function get_actor(_tx, _ty, _object) {
	with (_object) {
		if (tx == _tx && ty == _ty) {
			return id;
		}
	}
	return noone;
}
