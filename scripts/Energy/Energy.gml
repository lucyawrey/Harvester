#macro MAX_ENERGY TICKS_PER_DAY

function energy_spend(_amount = 1) {
	if (state.save.energy > 0) {
		if (_amount > 0) {
			state.save.energy -= _amount;
		}
	} else {
		state.save.exhaustion += _amount * irandom_range(1, 2);
	}
}

function energy_clamp(_value) {
	return clamp(0, MAX_ENERGY, _value);
}
