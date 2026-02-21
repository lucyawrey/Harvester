// Configure game settings
gpu_set_tex_filter(false);
setup_camera();
set_active_plane(PLANE.INTERIOR);
hide_event_layers();
set_light();

// Create objects
instance_create_depth(0, 0, 0, obj_clock);
