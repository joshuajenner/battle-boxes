class_name ResolutionOptionButton
extends OptionButton


var resolution_items: Array[Vector2i] = []


func _ready() -> void:
	populate_resolution_items()
	on_window_size_changed()
	on_window_mode_changed(VideoSettings.window_mode)
	item_selected.connect(on_item_selected)
	VideoSettings.window_mode_changed.connect(on_window_mode_changed)
	get_window().size_changed.connect(on_window_size_changed)


func on_item_selected(index: int) -> void:
	VideoSettings.set_resolution(resolution_items[index])


func on_window_size_changed() -> void:
	var window_size: Vector2i = get_window().size
	var res_index: int = resolution_items.find(window_size)
	if res_index != -1:
		select(res_index)
	text = str(window_size.x) + " x " + str(window_size.y)


func on_window_mode_changed(mode: Window.Mode) -> void:
	disabled = mode != Window.MODE_WINDOWED


func populate_resolution_items() -> void:
	clear()
	var screen_resolution: Vector2i = DisplayServer.screen_get_size()
	var base_width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var base_height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
	var base_game_resolution := Vector2i(base_width, base_height)
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
