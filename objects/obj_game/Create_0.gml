// Configure game settings
gpu_set_tex_filter(false);
setup_camera();
set_active_plane(PLANE.INTERIOR);
layer_setup();
set_light_for_time(state.save.time);
randomise();

// Create objects
instance_create_depth(0, 0, 30, obj_clock);
instance_create_depth(0, 0, 30, obj_meter);
