#macro ITEMS global.__items

ITEMS = {};

function try_collect_item(_x, _y, ) {
    var _target_item = instance_position(_x + 2, _y + 2, obj_item);
    if (_target_item != noone) {
        _target_item.collect();
        return true;
    }
    return false;
}
