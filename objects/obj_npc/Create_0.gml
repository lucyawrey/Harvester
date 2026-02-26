event_inherited();

function on_tick() {
    if (irandom_range(0, 1)) {
        move(point_facing(tx, ty, obj_player.tx, obj_player.ty), 1);
    }
}
