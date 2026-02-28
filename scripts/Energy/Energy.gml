function energy_spend(_amount = 1) {
    if (state.save.energy > 0) {
        state.save.energy--;
    } else {
        state.save.exhaustion += irandom_range(1, 2);
    }
}
