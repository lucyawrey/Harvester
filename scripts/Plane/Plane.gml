enum PLANE {
	INTERIOR = 0,
	EXTERIOR = 1,
}

#macro PLANES [["IActor", "I2", "I1"], ["EActor", "E2", "E1"]]
#macro ACTOR_LAYERS ["IActor", "EActor"]
#macro EVENT_LAYERS ["IEvent", "EEvent"]
#macro LAYERS_2 ["I2", "E2"]
#macro LIGHT_LAYERS ["Sun", "Moon"]

function set_active_plane(_new_plane) {
	for (var _i = 0; _i < array_length(PLANES); _i++) {
		for (var _j = 0; _j < array_length(PLANES[_i]); _j++) {
			layer_set_visible(PLANES[_i][_j], (_i == _new_plane));
		}
	}
}

function get_plane_from_layer(_layer) {
	var _name = layer_get_name(_layer);
	for (var _i = 0; _i < array_length(PLANES); _i++) {
		for (var _j = 0; _j < array_length(PLANES[_i]); _j++) {
			if (_name == PLANES[_i][_j]) {
				return _i;
			}
		}
	}
}

function get_actor_layer_id(_plane) {
	return layer_get_id(ACTOR_LAYERS[_plane]);
}

function layer_setup() {
	for (var _i = 0; _i < 2; _i++) {
		layer_set_visible(EVENT_LAYERS[_i], false);
		layer_set_visible(LIGHT_LAYERS[_i], true);
	}
	layer_set_visible("Grid", false);
}
