class_name WindowModeOptionButton
extends OptionButton


var modes: Dictionary = {
	"Windowed": Window.MODE_WINDOWED,
	"Maximized": Window.MODE_MAXIMIZED,
	"Borderless Fullscreen": Window.MODE_FULLSCREEN,
	"Fullscreen": Window.MODE_EXCLUSIVE_FULLSCREEN,
}


func _ready() -> void:
	add_modes_to_items()
	select(get_item_index(VideoSettings.window_mode))
	VideoSettings.window_mode_changed.connect(on_window_mode_changed)
	item_selected.connect(on_item_selected)


func on_item_selected(index: int) -> void:
	var mode: Window.Mode = get_item_id(index) as Window.Mode
	VideoSettings.set_window_mode(mode)


func on_window_mode_changed(mode: Window.Mode) -> void:
	select(get_item_index(mode))


func add_modes_to_items() -> void:
	clear()
	for mode in modes:
		add_item(mode, modes[mode])
