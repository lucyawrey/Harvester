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

enum TILE {
	TILLED = 41,
}

enum EVENT {
	VOID = 0,
	GROUND = 1,
	WALL = 2,
	DOOR = 3,
	SOIL = 4,
	TILLED = 5,
}

function pixel(_tiles) {
	return _tiles * TILE_SIZE;
}

function point_facing(_x1, _y1, _x2, _y2) {
	var _x = _x2 - _x1, _y = _y2 - _y1;
	if (_x == 0 && _y == 0) {
		return FACING.NONE;
	}
	if (abs(_x) > abs(_y)) {
		if (_x > 0) {
			return FACING.RIGHT;
		} else {
			return FACING.LEFT;
		}
	} else {
		if (_y > 0) {
			return FACING.DOWN;
		} else {
			return FACING.UP;
		}
	}
}

function object_is_type(_instance, _object) {
	return _instance.object_index == _object
		|| object_is_ancestor(_instance.object_index, _object);
}
