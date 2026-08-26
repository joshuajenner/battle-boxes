class_name ResolutionOptionButton
extends OptionButton


signal resolution_selected(resolution: Vector2i)


var resolution_items: Array[Vector2i] = []
const RES_NOT_FOUND_STRING: String = "Maximized"


func _ready() -> void:
	clear()
	populate_resolution_items()
	item_selected.connect(on_item_selected)
	get_window().size_changed.connect(on_window_size_changed)


func on_item_selected(index: int) -> void:
	resolution_selected.emit(resolution_items[index])


func on_window_size_changed() -> void:
	var res_index: int = resolution_items.find(get_window().size)
	if res_index == -1:
		text = RES_NOT_FOUND_STRING
	else:
		var res: Vector2i = resolution_items[res_index]
		text = str(res.x) + " x " + str(res.y)


func populate_resolution_items() -> void:
	var screen_resolution: Vector2i = DisplayServer.screen_get_size()
	var base_game_resolution := Vector2i(640, 360)
	var scale: int = 1
	var limit_found: bool = false
	
	while not limit_found:
		var new_res: Vector2i = base_game_resolution * scale
		if new_res <= screen_resolution:
			var res_label: String = str(new_res.x) + " x " + str(new_res.y)
			resolution_items.append(new_res)
			add_item(res_label)
			scale += 1
		else:
			limit_found = true
