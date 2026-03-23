event_inherited();

function on_interact(_tool = TOOL.NONE) {
	show_dialogue("Skelechat");
}

function on_tick() {
	ai_random_move(id);
}
