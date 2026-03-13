var _season = SEASONS[state.save.season];
var _day = state.save.day;
var _time_split = string_split(tick_to_time(state.save.time, false), " ");
var _time = _time_split[0];
var _period = _time_split[1];

var _dx = VIEW_WIDTH - 73;
var _dy = 2;

draw_sprite_stretched(spr_box, 0, _dx - 3, _dy, 74, 32);

scribble($"[{DEFAULT_COLOUR}]{_season} {_day}").draw(_dx, _dy);
_dy += 14;
scribble($"[{DEFAULT_COLOUR}]{_time}").draw(_dx, _dy);
scribble($"[{DEFAULT_COLOUR}]{_period}").draw(_dx + 44, _dy);
