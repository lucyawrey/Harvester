#macro TILES_PATH "*tiles.json"
#macro TOTAL_TILES 256

function load_tiles() {
	var _tiles = load_json_files_to_array(TILES_PATH);
	array_foreach(_tiles, function(_tile) {
		if (struct_exists(_tile, "id")) {
			if (_tile.id == 0) {
				state.default_tile = _tile;
			}
			state.tiles[_tile.id] = _tile;
			if (struct_exists(_tile, "name")) {
				state.tiles_index[$ _tile.name] = _tile.id;
			}
		}
	});
	log(state.tiles);
}

function load_json_files_to_array(_mask) {
	var _output = [];
	var _files = find_files(_mask);
	for (var _i = 0; _i < array_length(_files); _i++) {
		var _file = _files[_i];
		var _json = read_text_from_file_by_filename(_file);
		var _data = json_parse(_json);
		_output = array_concat(_output, _data);
	}
	return _output;
}

// Finds matching files for the provided mask
function find_files(_mask) {
	var _files = [];
	var _filename = file_find_first(_mask, fa_directory | fa_none);
	while (_filename != "") {
		array_push(_files, _filename);
		_filename = file_find_next();
	}
	file_find_close();
	return _files;
}

function find_directories(_mask) {
	var _files = find_files(_mask + "*");
	var _dirs = [];
	for (var _i = 0; _i < array_length(_files); _i++) {
		var _file = _files[_i];
		if (directory_exists(_mask + _file)) {
			array_push(_dirs, _file);
		}
	}
	return _dirs;
}

function write_text_to_file_by_filename(_filename, _text) {
	var _file = file_text_open_write(_filename);
	file_text_write_string(_file, _text);
	file_text_close(_file);
}

function read_text_from_file_by_filename(_filename) {
	var _file_buffer = buffer_load(_filename);
	var _text = buffer_read(_file_buffer, buffer_string);
	buffer_delete(_file_buffer);
	return _text;
}
