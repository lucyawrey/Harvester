if (InputReleased(VERB.ACCEPT)) {
	if (inside) {
		layer_set_visible("I1", false);
		layer_set_visible("I2", false);
		layer_set_visible("IE", false);
		layer_set_visible("E1", true);
		layer_set_visible("E2", true);
		layer_set_visible("EE", true);
        obj_player.layer = layer_get_id("EE");
		inside = false;
	} else {
		layer_set_visible("I1", true);
		layer_set_visible("I2", true);
		layer_set_visible("IE", true);
		layer_set_visible("E1", false);
		layer_set_visible("E2", false);
		layer_set_visible("EE", false);
        obj_player.layer = layer_get_id("IE");
		inside = true;
	}
}
