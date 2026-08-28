extends Node


# VideoSettings Autoload

signal window_mode_changed(mode: Window.Mode)
signal changed()
signal loaded_user()
signal saved()


const SECTION_DISPLAY: String = "display"
const KEY_WINDOW_MODE: String = "window_mode"
const KEY_RESOLUTION: String = "resolution"

const SETTINGS_FILE_PATH: String = "user://video_settings.cfg"

var window_mode := Window.MODE_WINDOWED
var resolution := Vector2i.ZERO


func _ready() -> void:
	load_user()


func set_window_mode(mode_index: int) -> void:
	var mode := mode_index as Window.Mode
	window_mode = mode
	get_window().mode = mode
	if mode == Window.MODE_WINDOWED:
		set_resolution(resolution)
	window_mode_changed.emit(mode)
	changed.emit()


func set_resolution(res: Vector2i) -> void:
	resolution = res
	if window_mode == Window.MODE_WINDOWED:
		get_window().size = res
		center_window(resolution)
	changed.emit()


func center_window(window_size: Vector2i) -> void:
	var screen_index: int = get_window().current_screen
	var screen_position: Vector2i = DisplayServer.screen_get_position(screen_index)
	var window_offset: Vector2i = DisplayServer.screen_get_size(screen_index) / 2 - window_size / 2
	get_window().position = screen_position + window_offset


func save() -> void:
	var config := ConfigFile.new()
	config.set_value(SECTION_DISPLAY, KEY_WINDOW_MODE, window_mode)
	config.set_value(SECTION_DISPLAY, KEY_RESOLUTION, resolution)
	var error: Error = config.save(SETTINGS_FILE_PATH)
	if error == OK:
		saved.emit()


func load_user() -> void:
	var config = ConfigFile.new()
	var error: Error = config.load(SETTINGS_FILE_PATH)
	if error == OK:
		set_window_mode(config.get_value(SECTION_DISPLAY, KEY_WINDOW_MODE))
		set_resolution(config.get_value(SECTION_DISPLAY, KEY_RESOLUTION))
		loaded_user.emit()
	else:
		load_default()


func load_default() -> void:
	set_window_mode(Window.MODE_WINDOWED)
	var width: int = ProjectSettings.get_setting("display/window/size/viewport_width")
	var height: int = ProjectSettings.get_setting("display/window/size/viewport_height")
	set_resolution(Vector2i(width, height))
