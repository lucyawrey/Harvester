if (InputReleased(VERB.ACCEPT)) {
	set_active_plane(
		state.player_active_plane == PLANE.INTERIOR ? PLANE.EXTERIOR : PLANE.INTERIOR
	);
}
