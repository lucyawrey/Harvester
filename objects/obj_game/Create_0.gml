// Configure game settings
gpu_set_tex_filter(false);
setup_camera();
layer_setup();
set_light_for_time(state.save.time);
randomise();

// Load data
load_tiles();

// Create objects
instance_create_depth(0, 0, 30, obj_clock);
instance_create_depth(0, 0, 30, obj_meter);
