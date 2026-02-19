// TODO better analogue input handling
if (InputPressed(VERB.DOWN)) {
    y += TILE_SIZE;
    image_index = 1;
    facing_direction = VERB.DOWN;
} else if (InputPressed(VERB.LEFT)) {
    x -= TILE_SIZE;
    image_index = 4;
    facing_direction = VERB.LEFT;
} else if (InputPressed(VERB.RIGHT)) {
    x += TILE_SIZE;
    image_index = 7;
    facing_direction = VERB.RIGHT;
} else if (InputPressed(VERB.UP)) {
    y -= TILE_SIZE;
    image_index = 10;
    facing_direction = VERB.UP;
}
