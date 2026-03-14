enum TOOL {
	NONE = 0,
	CAN = 1,
	HOE = 2,
	HAMMER = 3,
	AXE = 4,
	SCYTHE = 5,
	SHOVEL = 6,
}

enum TIER {
	COPPER = 0,
	SILVER = 1,
	GOLD = 2,
	MITHRIL = 3,
}

#macro INVENTORY_SLOTS 12
#macro STACK_SIZE 99
#macro DEFAULT_ITEM_ID "default"

function get_slot(_inventory, _number) {
	var _slot = _inventory[_number];
	return is_struct(_slot) && struct_exists(_slot, "id")
		? {slot: _slot, item: get_item(_slot.id)}
		: undefined;
}

function get_item(_item_id = "") {
	// Set default id
	if (_item_id == "") {
		_item_id = DEFAULT_ITEM_ID;
	}
	// Fetch item from cache if able
	if (struct_exists(state.items_cache, _item_id)) {
		return struct_get(state.items_cache, _item_id);
	}
	// Fail if base item not available.
	if (!struct_exists(state.items, DEFAULT_ITEM_ID)) {
		return;
	}
	var _base_item = struct_get(state.items, DEFAULT_ITEM_ID);

	var _item_names = string_split(_item_id, ".", true);

	_item_queue = [_base_item, {name: _item_names[0]}]; // Function scoped
	_last_item = undefined; // Function scoped

	array_foreach(_item_names, function(_name) {
		var _item = is_struct(_last_item)
		&& struct_exists(_last_item, "variants")
		&& struct_exists(_last_item.variants, _name)
			? struct_get(_last_item.variants, _name)
			: (struct_exists(state.items, _name)
				? struct_get(state.items, _name)
				: undefined);
		if (is_struct(_item)) {
			array_push(_item_queue, _item);
			_last_item = _item;
		}
	});

	var _sprite_name = struct_get_merged(_item_queue, "sprite");
	_sprite_name = add_prefix(_sprite_name, "spr_item_");
	var _sprite = asset_get_index(_sprite_name);
	if (asset_get_type(_sprite) != asset_sprite) {
		_sprite = undefined;
	}

	var _item = {
		id: _item_id,
		name: struct_get_merged(_item_queue, "name"),
		sprite: _sprite,
		tool_type: struct_get_merged(_item_queue, "tool_type"),
		tier: struct_get_merged(_item_queue, "tier"),
	};

	struct_set(state.items_cache, _item_id, _item);

	return _item;
}
