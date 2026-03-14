event_inherited();

function collect() {
	instance_destroy();
}

function on_interact() {
	log("test!!!!!!!!!");
	collect();
}

function on_enter() {
	collect();
}
