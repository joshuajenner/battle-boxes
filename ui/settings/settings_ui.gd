extends TabContainer


@export var window_mode_option_button: WindowModeOptionButton
@export var resolution_option_button: ResolutionOptionButton


func _ready() -> void:
	window_mode_option_button.window_mode_selected.connect(on_window_mode_selected)
	resolution_option_button.resolution_selected.connect(on_resolution_selected)


func on_window_mode_selected(mode_index: int) -> void:
	Settings.window_mode = mode_index
	get_window().mode = mode_index
	resolution_option_button.on_window_mode_changed(mode_index)
	if mode_index == Window.MODE_WINDOWED:
		get_window().size = Settings.resolution
		center_window(Settings.resolution)


func on_resolution_selected(res: Vector2i) -> void:
	Settings.resolution = res
	get_window().size = res 
	center_window(res)


func center_window(window_size: Vector2i) -> void:
	var screen_index: int = get_window().current_screen
	var screen_position: Vector2i = DisplayServer.screen_get_position(screen_index)
	var window_offset: Vector2i = DisplayServer.screen_get_size(screen_index) / 2 - window_size / 2
	get_window().position = screen_position + window_offset
