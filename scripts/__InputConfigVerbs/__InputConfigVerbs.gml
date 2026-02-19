function __InputConfigVerbs() {
	enum VERB {
		//Add your own verbs here!
		UP,
		DOWN,
		LEFT,
		RIGHT,
		ACCEPT,
		CANCEL,
		MENU,
	}

	enum CLUSTER {
		NAVIGATION,
	}

	InputDefineVerb(VERB.UP, "up", [vk_up, "W"], [-gp_axislv, gp_padu]);
	InputDefineVerb(VERB.DOWN, "down", [vk_down, "S"], [gp_axislv, gp_padd]);
	InputDefineVerb(VERB.LEFT, "left", [vk_left, "A"], [-gp_axislh, gp_padl]);
	InputDefineVerb(VERB.RIGHT, "right", [vk_right, "D"], [gp_axislh, gp_padr]);
	InputDefineVerb(
		VERB.MENU,
		"menu",
		[vk_enter, vk_escape],
		[gp_start, gp_touchpadbutton]
	);

	if (INPUT_ON_SWITCH) {
		//Flip A/B over on Switch
		InputDefineVerb(VERB.ACCEPT, "accept", undefined, gp_face2); // !!
		InputDefineVerb(VERB.CANCEL, "cancel", undefined, gp_face1); // !!
	} else {
		InputDefineVerb(VERB.ACCEPT, "accept", ["Z", vk_space], gp_face1);
		InputDefineVerb(VERB.CANCEL, "cancel", "X", gp_face2);
	}

	//Define a cluster of verbs for moving around
	InputDefineCluster(
		CLUSTER.NAVIGATION,
		VERB.UP,
		VERB.RIGHT,
		VERB.DOWN,
		VERB.LEFT,
		1
	);
}
