function tile_get(_id_name) {
    // Handle out of bounds
    if (_id_name == -1) {
        _id_name = 0;
    }
	// TODO move most of this logic to load_tiles
	if (is_string(_id_name)) {
		_id_name = tile_get_id(_id_name);
	}
	var _structs = [state.default_tile];
	if (_id_name != 0 && is_real(_id_name)) {
		array_push(_structs, {id: _id_name, name: $"tile{_id_name}"});
		if (_id_name < array_length(state.tiles) && state.tiles[_id_name] != 0) {
			array_push(_structs, state.tiles[_id_name]);
		}
	}
	return {
		id: struct_get_merged(_structs, "id"),
		name: struct_get_merged(_structs, "name"),
		is_solid: struct_get_merged(_structs, "is_solid"),
		is_soil: struct_get_merged(_structs, "is_soil"),
		enter: struct_get_merged(_structs, "enter"),
		interact: struct_get_merged(_structs, "interact"),
	};
}

function tile_get_id(_name) {
	if (is_string(_name) && struct_exists(state.tiles_index, _name)) {
		return struct_get(state.tiles_index, _name);
	}
	return 0;
}

function tilemap_get_tile(_tilemap_element_id, _x_cell, _y_cell) {
	return tile_get(tilemap_get(_tilemap_element_id, _x_cell, _y_cell));
}
