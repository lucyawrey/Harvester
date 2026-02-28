event_inherited();

function collect() {
	instance_destroy();
}

function on_interact() {
	collect();
}

function on_intersect() {
	collect();
}
