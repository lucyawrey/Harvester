if (InputReleased(INPUT_VERB.ACCEPT)) {
    if (inside) {
        layer_set_visible("InteriorWall", false);
        layer_set_visible("InteriorFloor", false);
        layer_set_visible("ExteriorWall", true);
        layer_set_visible("ExteriorFloor", true);
        inside = false;
    } else {
        layer_set_visible("InteriorWall", true);
        layer_set_visible("InteriorFloor", true);
        layer_set_visible("ExteriorWall", false);
        layer_set_visible("ExteriorFloor", false);
        inside = true;
    }
}
