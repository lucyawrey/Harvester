#macro DAYS_PER_SEASON 28
#macro MINUTES_PER_TICK 5

#macro SEASONS_PER_YEAR 4
#macro HOURS_PER_DAY 24
#macro MINUTES_PER_HOUR 60
#macro MINUTES_PER_DAY (HOURS_PER_DAY * MINUTES_PER_HOUR)
#macro TICKS_PER_DAY (MINUTES_PER_DAY / MINUTES_PER_TICK)

enum SEASON {
	SPRING = 1,
	SUMMER = 2,
	FALL = 3,
	WINTER = 4,
}
#macro SEASONS ["Void", "Spring", "Summer", "Fall", "Winter"]

function tick(_amount = 1) {
	with (obj_npc) {
		on_tick();
	}

	state.save.time += _amount;
	if (state.save.time == TICKS_PER_DAY) {
		state.save.time = 0;
		state.save.day++;

		with (obj_crop) {
			grow();
		}

		if (state.save.day > DAYS_PER_SEASON) {
			state.save.day = 1;
			state.save.season++;
			if (state.save.season > SEASONS_PER_YEAR) {
				state.save.season = 1;
				state.save.year++;
			}
		}
	}
	set_light_for_time(state.save.time);
    
    energy_spend();
}

function time_to_tick(_time) {
	var _split = string_split(string_trim(_time), ":");
	if (array_length(_split) != 2) {
		return -1;
	}
	var _hours = real(_split[0]);
	var _minutes = real(_split[1]);

	_minutes += _hours * MINUTES_PER_HOUR;
	return _minutes div MINUTES_PER_TICK;
}

function tick_to_time(_ticks, _twenty_four_hour = true) {
	var _total_minutes = _ticks * MINUTES_PER_TICK;
	var _hours = _total_minutes div MINUTES_PER_HOUR;
	var _minutes = _total_minutes % MINUTES_PER_HOUR;
	var _prefix = _minutes < 10 ? "0" : "";
	var _suffix = "";

	if (!_twenty_four_hour) {
		_suffix = _hours < 12 ? "AM" : "PM";
		_hours = _hours % 12 == 0 ? 12 : _hours % 12;
	}

	return $"{_hours}:{_prefix}{_minutes} {_suffix}";
}
