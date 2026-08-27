class_name WindowModeOptionButton
extends OptionButton


signal window_mode_selected(mode_index: int)


var modes: Dictionary = {
	"Windowed": Window.MODE_WINDOWED,
	"Maximized": Window.MODE_MAXIMIZED,
	"Borderless Fullscreen": Window.MODE_FULLSCREEN,
	"Fullscreen": Window.MODE_EXCLUSIVE_FULLSCREEN,
}


func _ready() -> void:
	add_modes_to_items()
	select(get_item_index(Settings.window_mode))
	item_selected.connect(on_item_selected)


func on_item_selected(index: int) -> void:
	window_mode_selected.emit(get_item_id(index))


func add_modes_to_items() -> void:
	for mode in modes:
		add_item(mode, modes[mode])
