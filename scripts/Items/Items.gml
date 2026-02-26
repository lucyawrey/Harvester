#macro ITEMS global.__items

ITEMS = {};

function try_collect_item(_tx, _ty) {
	var _target_item = instance_position(pixel(_tx) + 2, pixel(_ty) + 2, obj_item);
	if (_target_item != noone) {
		_target_item.collect();
		return true;
	}
	return false;
}
