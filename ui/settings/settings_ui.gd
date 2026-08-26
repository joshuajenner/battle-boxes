extends TabContainer


@export var resolution_option_button: ResolutionOptionButton


func _ready() -> void:
	resolution_option_button.resolution_selected.connect(on_resolution_selected)


func on_resolution_selected(res: Vector2i) -> void:
	get_window().size = res
	var screen_index: int = get_window().current_screen
	var screen_position: Vector2i = DisplayServer.screen_get_position(screen_index)
	var window_offset: Vector2i = DisplayServer.screen_get_size(screen_index) / 2 - res / 2
	get_window().position = screen_position + window_offset
