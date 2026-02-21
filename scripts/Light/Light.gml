#macro SUN layer_background_get_id("Sun")
#macro MOON layer_background_get_id("Moon")

function set_light_for_time(_time) {
    var _time_factor = _time >= time_to_tick("6:00") && _time < time_to_tick("18:00") ? 5 : -30;
    var _r = 3 * _time_factor, _g = 2 * _time_factor, _b = 1 * _time_factor;
    set_light_layer_background_blends(_r, _g, _b);
}

function set_light_layer_background_blends(_r, _g, _b) {
    var c_sun = make_color_rgb(clamp(_r, 0, 255), clamp(_g, 0, 255), clamp(_b, 0, 255));
    var c_moon = make_color_rgb(-clamp(_r, -255, 0), -clamp(_g, -255, 0), -clamp(_b, -255, 0));
    layer_background_blend(SUN, c_sun);
    layer_background_blend(MOON, c_moon);
}
