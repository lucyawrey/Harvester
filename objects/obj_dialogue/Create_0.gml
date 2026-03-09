// Set instance variables
visible = false;
typist = scribble_setup(); // Set up Scribble plugin for text rendering
chatterbox = chatterbox_setup(); // Set up Chatterbox plugin for dialogue scripting
current_state = DIALOGUE_STATE.TEXT;
current_node_metadata = {};
current_text = "";
current_metadata = [];
current_options = [];
current_selection = -2;
current_character = get_character();
current_background_sprite = undefined;
current_shown_sprites = {};
current_character_blocking = {};
current_music = undefined;
advance_icon_rotation = 0;
draw_fullscreen = false;
delay_behavior = "";
is_delay = false;
delay_finished = false;

// Method definitions
function continue_on() {
	if (ChatterboxIsStopped(chatterbox)) {
		visible = false;
	} else if (ChatterboxIsWaiting(chatterbox)) {
		show_advance_icon = false;
		ChatterboxContinue(chatterbox);
		if (current_state == DIALOGUE_STATE.OPTION) {
			current_state = DIALOGUE_STATE.TEXT;
		}
		if (!is_delay || delay_behavior == "auto") {
			get_current_content();
		}
	} else {
		current_state = DIALOGUE_STATE.OPTION;
		current_options = ChatterboxGetOptionArray(chatterbox);
	}
}

function get_current_content() {
	var _content = get_content();
	current_text = scribble_markdown_format(_content.text);
	current_metadata = _content.metadata;
	current_character = _content.character;
	draw_fullscreen = current_character.fullscreen;
}

function is_blocked_right() {
	if (
		struct_exists(current_character_blocking, current_character.id)
		&& struct_get(current_character_blocking, current_character.id) == "right"
	) {
		return true;
	}
	return false;
}
