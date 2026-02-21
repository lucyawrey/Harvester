enum LIGHT_TIME {
    DAY = 0,
    NIGHT = 1,
}

#macro LIGHT_LAYERS ["Day", "Night"]
#macro DAY_BG layer_background_get_id("Day")
#macro NIGHT_BG layer_background_get_id("Night")

function set_light() {
    var _time = state.save.time;
    var _light_time = _time > time_to_tick("5:30") && _time < time_to_tick("19:00") ? LIGHT_TIME.DAY : LIGHT_TIME.NIGHT;
    set_light_layers(_light_time);
}

// TODO chnage to show both additive and negative layers always, only chnage tinting
function set_light_layers(_light_time) {
    for (var _i = 0; _i < array_length(LIGHT_LAYERS); _i++) {
    	layer_set_visible(LIGHT_LAYERS[_i], _light_time == _i);
    }
}
