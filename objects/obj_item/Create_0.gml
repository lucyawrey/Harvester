event_inherited();

function collect() {
    // TODO handle any character collecting item
    if (obj_player.add_item("tomato")) {
        instance_destroy();
    }
}

function on_interact() {
	collect();
}

function on_enter() {
	collect();
}
