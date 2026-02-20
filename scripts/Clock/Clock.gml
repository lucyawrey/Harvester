#macro SEASONS_PER_YEAR 4
#macro DAYS_PER_SEASON 28
#macro MINUTES_PER_TICK 5

#macro HOURS_PER_DAY 24
#macro MINUTES_PER_HOUR 60
#macro MINUTES_PER_DAY (HOURS_PER_DAY * MINUTES_PER_HOUR)
#macro TICKS_PER_DAY (MINUTES_PER_DAY / MINUTES_PER_TICK)

function tick(_amount = 1) {
	state.save.time += _amount;
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

function tick_to_time(_ticks) {
	var _total_minutes = _ticks * MINUTES_PER_TICK;
	var _hours = _total_minutes div MINUTES_PER_HOUR;
	var _minutes = _total_minutes % MINUTES_PER_HOUR;
    var _leading = _minutes < 10 ? "0" : "";
	return $"{_hours}:{_leading}{_minutes}";
}
