event_inherited();

function on_interact() {
	show_dialogue("Skelechat");
}

function on_tick() {
	ai_random_move(id);
}
