#macro TILES_PATH "*tiles.json"
#macro CHARACTERS_PATH "*characters.json"
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
}

function load_character_files(_directory) {
	state.characters = load_json_files_to_struct(CHARACTERS_PATH);
}

function load_json_files_to_struct(_mask) {
	var _output = {};
	var _files = find_files(_mask);
	for (var _i = 0; _i < array_length(_files); _i++) {
		var _file = _files[_i];
		var _json = read_text_from_file_by_filename(_file);
		var _data = json_parse(_json);
		struct_merge(_output, _data);
	}
	return _output;
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

function load_all_chatterbox_files_to_buffer(_buffer, _directory = "") {
	load_yarn_files(_buffer, _directory);
	load_character_files(_directory);
	var _subdirs = find_directories(_directory);
	for (var _i = 0; _i < array_length(_subdirs); _i++) {
		load_all_chatterbox_files_to_buffer(_buffer, _directory + _subdirs[_i] + "/");
	}
}

function load_all_chatterbox() {
	var _buffer = buffer_create(1048576, buffer_grow, 1);
	load_all_chatterbox_files_to_buffer(_buffer);
	ChatterboxLoadFromBuffer("default", _buffer);
	buffer_delete(_buffer);
}

function load_yarn_files(_buffer, _directory) {
	var _yarn_files = find_files(_directory + "*.yarn");
	for (var _i = 0; _i < array_length(_yarn_files); _i++) {
		var _yarn_file = _directory + _yarn_files[_i];
		buffer_load_ext(_buffer, _yarn_file, buffer_get_used_size(_buffer));
	}
}
