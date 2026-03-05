#macro AUTO_MOVE_DELAY 10

enum FACING {
	NONE = -1,
	DOWN = 0,
	LEFT = 1,
	RIGHT = 2,
	UP = 3,
}

enum SPRITE {
	DOWN_WALK_1 = 0,
	DOWN = 1,
	DOWN_WALK_2 = 2,
	LEFT_WALK_1 = 3,
	LEFT = 4,
	LEFT_WALK_2 = 5,
	RIGHT_WALK_1 = 6,
	RIGHT = 7,
	RIGHT_WALK_2 = 8,
	UP_WALK_1 = 9,
	UP = 10,
	UP_WALK_2 = 11,
}

#macro VECTORS [{x: 0, y: 1}, {x: -1, y: 0}, {x: 1, y: 0}, {x: 0, y: -1}]
#macro DEADZONE 0.5

function pixel(_tiles) {
	return _tiles * TILE_SIZE;
}

function angle_facing(_angle) {
	var _direction = round(_angle / 90) % 4;
	switch (_direction) {
		case 0:
			return FACING.RIGHT;
		case 1:
			return FACING.UP;
		case 2:
			return FACING.LEFT;
		case 3:
			return FACING.DOWN;
	}
}

function point_facing(_x1, _y1, _x2, _y2) {
	return angle_facing(point_direction(_x1, _y1, _x2, _y2));
}

function object_is_type(_instance, _object) {
	return _instance.object_index == _object
		|| object_is_ancestor(_instance.object_index, _object);
}
