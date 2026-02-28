#macro state global.__state
#macro INITIAL_STATE global.__initial_state

state = {
	/* game_data/save_[save_slot].json */
	save: {
		/* Player character values */
		name: "Avery",
		body_type: BODY_TYPE.NEUTRAL,
		pronoun_set: PRONOUN_TYPE.THEY,
		/* Clock values */
		day: 1,
		season: 1,
		year: 1,
		time: time_to_tick("6:00"),
        /* Player values */
        energy: MAX_ENERGY,
        exhaustion: 0,
	},
	/* game_data/save_shared.json */
	save_shared: {active_save_slot: 0},
	/* Non-saved global state */
	characters: {},
	characters_cache: {},
};

INITIAL_STATE = variable_clone(state);
