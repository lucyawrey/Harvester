enum PLANE {
	INTERIOR = 0,
	EXTERIOR = 1,
}

#macro PLANES [["IObject", "I2", "I1"], ["EObject", "E2", "E1"]]
#macro OBJECT_LAYERS ["IObject", "EObject"]
#macro EVENT_LAYERS ["IEvent", "EEvent"]
#macro LIGHT_LAYERS ["Sun", "Moon"]

function set_active_plane(_new_plane) {
	for (var _i = 0; _i < array_length(PLANES); _i++) {
		for (var _j = 0; _j < array_length(PLANES[_i]); _j++) {
			layer_set_visible(PLANES[_i][_j], (_i == _new_plane));
		}
	}
	obj_player.layer = get_object_layer_id(_new_plane);
	state.player_active_plane = _new_plane;
}

function get_object_layer_id(_plane) {
	return layer_get_id(OBJECT_LAYERS[_plane]);
}

function layer_setup() {
	for (var _i = 0; _i < 2; _i++) {
		layer_set_visible(EVENT_LAYERS[_i], false);
        layer_set_visible(LIGHT_LAYERS[_i], true);
	}
}
