var _dx = VIEW_WIDTH - 15;
var _dy = VIEW_HEIGHT - 59;
var _wx = 12;
var _hx = 56;
var _max_energy_height = 56 - 2;

draw_sprite_stretched(spr_box, 0, _dx, _dy, _wx, _hx);

var _exhaustion_height = ceil(state.save.exhaustion / MAX_ENERGY * _max_energy_height);
var _offset1 = _max_energy_height - _exhaustion_height;
if (_exhaustion_height >= 2) {
	draw_set_colour(c_red);
	draw_rectangle(
		_dx + 2,
		_dy + 2 + _offset1,
		_dx + _wx - 2,
		_dy + _exhaustion_height + _offset1,
		false
	);
}

var _energy_height = ceil(state.save.energy / MAX_ENERGY * _max_energy_height);
var _offset2 = _max_energy_height - _energy_height;
if (_energy_height >= 2) {
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
