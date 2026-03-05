function ai_random_move(_self) {
	with (_self) {
		move(irandom_range(0, 3), irandom_range(0, 1));
	}
}

function ai_cause_problems(_self) {
	with (_self) {
		if (irandom_range(0, 1)) {
			move(point_facing(tx, ty, obj_player.tx, obj_player.ty), 1);
		} else {
			interact();
		}
	}
}
