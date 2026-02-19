facing_direction = VERB.DOWN;
next_image_index = undefined;
anim_flag = false;

function set_animation_alarm() {
    alarm[0] = 15;
    anim_flag = !anim_flag;
}