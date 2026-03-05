enum PLANE {
	INTERIOR = 0,
	EXTERIOR = 1,
}

#macro PLANES [["Interior1", "Interior2"], ["Exterior1", "Exterior2"]]
#macro SHOW_LAYERS ["Sun", "Moon", "Void", "Actor"]

function set_active_plane(_new_plane) {
    state.save.active_plane = _new_plane;
	for (var _i = 0; _i < array_length(PLANES); _i++) {
		for (var _j = 0; _j < array_length(PLANES[_i]); _j++) {
			layer_set_visible(PLANES[_i][_j], (_i == _new_plane));
		}
	}
}

function layer_setup() {
	for (var _i = 0; _i < array_length(SHOW_LAYERS); _i++) {
		layer_set_visible(SHOW_LAYERS[_i], true);
	}
	layer_set_visible("Grid", false);
}
