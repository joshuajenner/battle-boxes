extends Node


const SECTION_DISPLAY: String = "display"
const KEY_WINDOW_MODE: String = "window_mode"
const KEY_RESOLUTION: String = "resolution"

const SETTINGS_FILE_PATH: String = "user://settings.cfg"

var window_mode: int = 0
var resolution := Vector2i.ZERO


func _ready() -> void:
	load_settings()
	apply_settings()


func save_settings() -> void:
	var config := ConfigFile.new()
	config.set_value(SECTION_DISPLAY, KEY_WINDOW_MODE, window_mode)
	config.set_value(SECTION_DISPLAY, KEY_RESOLUTION, resolution)
	config.save(SETTINGS_FILE_PATH)


func load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load(SETTINGS_FILE_PATH)
	if err == OK:
		window_mode = config.get_value(SECTION_DISPLAY, KEY_WINDOW_MODE)
		resolution = config.get_value(SECTION_DISPLAY, KEY_RESOLUTION)
	else:
		load_defaults()


func load_defaults() -> void:
	window_mode = Window.MODE_WINDOWED
	var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
	resolution = Vector2i(width, height)


func apply_settings() -> void:
	var window: Window = get_window()
	window.mode = window_mode
	if window_mode == Window.MODE_WINDOWED:
		window.size = resolution
		center_window(resolution)


func center_window(window_size: Vector2i) -> void:
	var screen_index: int = get_window().current_screen
	var screen_position: Vector2i = DisplayServer.screen_get_position(screen_index)
	var window_offset: Vector2i = DisplayServer.screen_get_size(screen_index) / 2 - window_size / 2
	get_window().position = screen_position + window_offset
