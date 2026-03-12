var _season = SEASONS[state.save.season];
var _day = state.save.day;
var _time_split = string_split(tick_to_time(state.save.time, false), " ");
var _time = _time_split[0];
var _period = _time_split[1];

var _dx = VIEW_WIDTH - 73;
var _dy = 2;

draw_sprite_stretched(spr_box, 0, _dx - 3, _dy, 74, 32);

// TODO correct font color #F1F4F7
draw_set_font(fnt_pixelop);
draw_text(_dx, _dy, $"{_season} {_day}");
_dy += 14;
draw_text(_dx, _dy, _time);
draw_text(_dx + 50, _dy, _period);
