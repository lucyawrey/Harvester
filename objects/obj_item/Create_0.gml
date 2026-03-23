event_inherited();

function collect() {
	// TODO fix crash when inventory is full
	// TODO handle any character collecting item
	if (obj_player.add_item("tomato")) {
		instance_destroy();
	}
}

function on_interact(_tool = TOOL.NONE) {
	collect();
}

function on_enter() {
	collect();
}
