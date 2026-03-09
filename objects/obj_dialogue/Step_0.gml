if (visible && !is_delay) {
	if (delay_finished) {
		delay_finished = false;
		continue_on();
	}

	if (current_state == DIALOGUE_STATE.TEXT) {
		//If we're in a Text state then let the user press space to advance dialogue, or right to fast forward
		if (InputPressed(VERB.ACCEPT) || InputCheck(VERB.CANCEL)) {
			if (typist.get_paused()) {
				typist.unpause();
				exit;
			}
			if (typist.get_state() < 1) {
				typist.skip_to_pause();
				audio_stop_sound(current_character.sound);
				exit;
			}
			continue_on();
		}
	} else if (current_state == DIALOGUE_STATE.OPTION) {
		var _option_count = array_length(current_options);
		if (current_selection == -2 && _option_count < 2) {
			current_selection = -1;
		}
		if (InputPressed(VERB.DOWN)) {
			play_nav_sound();
			if (current_selection < 0) {
				current_selection = -current_selection;
			}
			if (current_selection < _option_count) {
				current_selection++;
			} else {
				current_selection = 1;
			}
		} else if (InputPressed(VERB.UP)) {
			play_nav_sound();
			if (current_selection < 0) {
				current_selection = -current_selection;
			}
			if (current_selection > 1) {
				current_selection--;
			} else {
				current_selection = _option_count;
			}
		} else if (InputPressed(VERB.LEFT) || InputPressed(VERB.RIGHT)) {
			play_nav_sound();
			current_selection = -current_selection;
		}
		//If we've pressed Accept, submit the current selected option to Chatterbox
		if (InputPressed(VERB.ACCEPT) && current_selection > 0) {
			var _selection = current_selection - 1;
			play_nav_sound();
			ChatterboxSelect(chatterbox, _selection);
			if (current_meta_name != "none") {
				struct_set(state.save.selected_options, current_meta_name, _selection);
			}
			current_state = DIALOGUE_STATE.TEXT;
			get_current_content();
			current_selection = -2;
		}
	}
}

advance_icon_rotation = (advance_icon_rotation - 1.5) % 360;
