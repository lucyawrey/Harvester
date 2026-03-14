// Clock
var _season = SEASONS[state.save.season];
var _day = state.save.day;
var _time_split = string_split(tick_to_time(state.save.time, false), " ");
var _time = _time_split[0];
var _period = _time_split[1];

var _dx = VIEW_WIDTH - 73;
var _dy = 2;

draw_sprite_stretched(spr_box1, 0, _dx - 3, _dy, 74, 32);

scribble($"[{DEFAULT_COLOUR}]{_season} {_day}").draw(_dx, _dy);
_dy += 14;
scribble($"[{DEFAULT_COLOUR}]{_time}").draw(_dx, _dy);
scribble($"[{DEFAULT_COLOUR}]{_period}").draw(_dx + 44, _dy);

// Energy meter
_dx = VIEW_WIDTH - 14;
_dy = VIEW_HEIGHT - 58;
var _wx = 12;
var _hx = 56;
var _max_energy_height = 56 - 2;

draw_sprite_stretched(spr_box1, 0, _dx, _dy, _wx, _hx);

var _exhaustion_height = floor(state.save.exhaustion / MAX_ENERGY * _max_energy_height);
var _offset1 = _max_energy_height - _exhaustion_height;
if (_exhaustion_height > 2) {
	draw_set_colour(c_red);
	draw_rectangle(
		_dx + 2,
		_dy + 2 + _offset1,
		_dx + _wx - 2,
		_dy + _exhaustion_height + _offset1,
		false
	);
}

var _energy_height = floor(state.save.energy / MAX_ENERGY * _max_energy_height);
var _offset2 = _max_energy_height - _energy_height;
if (_energy_height > 1) {
	draw_set_colour(c_aqua);
	draw_rectangle(
		_dx + 2,
		_dy + 2 + _offset2,
		_dx + _wx - 2,
		_dy + _energy_height + _offset2,
		false
	);
	draw_set_colour(c_white);
}

// Item Bar
// TODO figure out item bar wrapping and rendering
for (var _i = 0; _i < 3; _i++) {
	
}
