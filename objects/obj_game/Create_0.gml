// Configure game settings
gpu_set_tex_filter(false);
setup_camera();
layer_setup();
set_light_for_time(state.save.time);
randomise();

// Load data
load_tiles();
load_items();
global._fnt_numbers = font_add_sprite(spr_numbers, ord("0"), false, -3);
#macro fnt_numbers font_get_fontname(global._fnt_numbers)

// Create objects
instance_create_depth(0, 0, -100, obj_hud);
instance_create_depth(0, 0, -100, obj_dialogue);
