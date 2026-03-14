#macro BASE_CHARACTER_NAME "Base"
#macro DEFAULT_CHARACTER_NAME "Narrator"
#macro DEFAULT_FONT "fnt_pixelop"
#macro DEFAULT_COLOUR "#F1F4F7"

enum DIALOGUE_STATE {
	TEXT,
	OPTION,
}

function chatterbox_setup() {
	load_all_chatterbox();
	var _chatterbox = ChatterboxCreate();

	// ChatterboxVariableSetCallback(on_chatterbox_variable_set); handle state sync

	ChatterboxAddFunction("background", background);
	ChatterboxAddFunction("show", show);
	ChatterboxAddFunction("hide", hide);
	ChatterboxAddFunction("play", play);
	ChatterboxAddFunction("pause", pause);
	ChatterboxAddFunction("delay", delay);
	ChatterboxAddFunction("auto", auto);
	ChatterboxAddFunction("block", block);

	return _chatterbox;
}

function scribble_setup() {
	var _typist = scribble_typist();
	_typist.in(1, 0);
	_typist.function_per_char(text_play_sound);
	_typist.function_on_complete(on_typist_complete);
	scribble_font_set_default(DEFAULT_FONT);
	return _typist;
}

function on_typist_complete() {
	if (obj_dialogue.is_delay && obj_dialogue.delay_behavior == "auto") {
		obj_dialogue.is_delay = false;
		obj_dialogue.delay_finished = true;
		obj_dialogue.alarm[0] = 0;
	}
}

function text_play_sound(_element, _position, _typist) {
	var _current_char = string_char_at(obj_dialogue.current_text, _position);
	if (_typist.get_skip() || _current_char == " ") {
		return;
	}
	var _rand_pitch = random_range(-0.2, 0.2);
	if (state.typist_sound_clock >= obj_dialogue.current_character.sound_spacing) {
		audio_play_sound(
			obj_dialogue.current_character.sound,
			1,
			false,
			0.5,
			undefined,
			obj_dialogue.current_character.sound_pitch + _rand_pitch
		);
		state.typist_sound_clock = 0;
	}
	{
		state.typist_sound_clock++;
	}
}

function show_dialogue(_node) {
	if (!instance_exists(obj_dialogue)) {
		return;
	}
	ChatterboxJump(obj_dialogue.chatterbox, _node);
	obj_dialogue.get_current_content();
	obj_dialogue.visible = true;
}

function hide_dialogue() {
	if (instance_exists(obj_dialogue)) {
		obj_dialogue.visible = false;
	}
}

function get_content() {
	if (!instance_exists(obj_dialogue)) {
		return;
	}

	var _all_content = ChatterboxGetContent(obj_dialogue.chatterbox, 0);
	var _speech_content = ChatterboxGetContentSpeech(obj_dialogue.chatterbox, 0);

	var _character_id = parse_character_id(_all_content, _speech_content);
	var _character = get_character(_character_id);
	var _metadata = ChatterboxGetContentMetadata(obj_dialogue.chatterbox, 0);

	return {character: _character, metadata: _metadata, text: _speech_content};
}

/**
 * Parses the current speaker ID, including any number of modifiers, and formats it into dot notation.
 * For example, "Stella[Awkward][Slow]" would become "Stella.Awkward.Slow"
 * @param _all_content - String. The full line of content, including speaker and their text
 * @param _speech_content - String. The text of what is being spoken
 * @returns The character_id of the speaker, including modifiers, in dot notation. Empty string otherwise
 */
function parse_character_id(_all_content, _speech_content) {
	_all_content = string_trim(_all_content);
	_speech_content = string_trim(_speech_content);

	var _speech_length = string_length(_speech_content);
	var _speaker_is_present = string_length(_all_content) != _speech_length;

	var _default_character_id = "";
	if (!_speaker_is_present) {
		return _default_character_id;
	}

	var _speaker_content = string_delete(
		_all_content,
		-1 * _speech_length,
		_speech_length
	);
	_speaker_content = string_trim(_speaker_content);
	_speaker_content = string_replace(_speaker_content, ":", "");
	_speaker_content = string_replace_all(_speaker_content, "[", ".");
	_speaker_content = string_replace_all(_speaker_content, "]", "");

	var _speaker_is_modifier_only = string_char_at(_speaker_content, 1) == ".";
	if (_speaker_is_modifier_only) {
		_speaker_content = string_delete(_speaker_content, 1, 1);
	}

	return _speaker_content;
}

// Characters
function get_character(_character_id = "") {
	// Set default id
	if (_character_id == "") {
		_character_id = DEFAULT_CHARACTER_NAME;
	}
	// Fetch character from cache if able
	if (struct_exists(state.characters_cache, _character_id)) {
		return struct_get(state.characters_cache, _character_id);
	}
	// Fail if base character not available.
	if (!struct_exists(state.characters, BASE_CHARACTER_NAME)) {
		return;
	}
	var _base_character = struct_get(state.characters, BASE_CHARACTER_NAME);

	var _character_names = string_split(_character_id, ".", true);

	_character_queue = [_base_character, {name: _character_names[0]}]; // Function scoped
	_last_character = undefined; // Function scoped

	array_foreach(_character_names, function(_name) {
		var _character = is_struct(_last_character)
		&& struct_exists(_last_character, "variants")
		&& struct_exists(_last_character.variants, _name)
			? struct_get(_last_character.variants, _name)
			: (struct_exists(state.characters, _name)
				? struct_get(state.characters, _name)
				: undefined);
		if (is_struct(_character)) {
			array_push(_character_queue, _character);
			_last_character = _character;
		}
	});

	// Get values
	var _sound_name = struct_get_merged(_character_queue, "sound");
	_sound_name = add_prefix(_sound_name, "snd_");
	var _sound = asset_get_index(_sound_name);
	if (asset_get_type(_sound) != asset_sound) {
		_sound = undefined;
	}

	var _background_name = struct_get_merged(_character_queue, "background");
	_background_name = add_prefix(_background_name, "spr_");
	var _background = asset_get_index(_background_name);
	if (asset_get_type(_background) != asset_sprite) {
		_background = undefined;
	}

	var _background_alt_name = struct_get_merged(_character_queue, "background_alt");
	_background_alt_name = add_prefix(_background_alt_name, "spr_");
	var _background_alt = asset_get_index(_background_alt_name);
	if (asset_get_type(_background_alt) != asset_sprite) {
		_background_alt = undefined;
	}

	var _font = add_prefix(struct_get_merged(_character_queue, "font"), "fnt_");

	var _character = {
		id: _character_id,
		sound: _sound,
		background: _background,
		background_alt: _background_alt,
		font: _font,
		name: struct_get_merged(_character_queue, "name"),
		name_color: struct_get_merged(_character_queue, "name_color"),
		text_color: struct_get_merged(_character_queue, "text_color"),
		text_speed: struct_get_merged(_character_queue, "text_speed"),
		prefix: struct_get_merged(_character_queue, "prefix"),
		suffix: struct_get_merged(_character_queue, "suffix"),
		sound_pitch: struct_get_merged(_character_queue, "sound_pitch"),
		sound_spacing: struct_get_merged(_character_queue, "sound_spacing"),
		fullscreen: struct_get_merged(_character_queue, "fullscreen"),
	};

	struct_set(state.characters_cache, _character_id, _character);

	return _character;
}

function add_prefix(_base_str, _prefix_str) {
	if (string_starts_with(_base_str, _prefix_str)) {
		return _base_str;
	} else {
		return _prefix_str + _base_str;
	}
}
