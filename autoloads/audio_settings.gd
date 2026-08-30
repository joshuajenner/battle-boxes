extends Node


# AudioSettings Autoload

signal changed()
signal loaded_user()
signal loaded_default()
signal saved()


const SECTION_VOLUME: String = "audio_volume"
const KEY_MASTER: String = "Master"
const KEY_GAME_SFX: String = "GameSFX"
const KEY_GAME_MUSIC: String = "GameMusic"
const KEY_MENU_SFX: String = "MenuSFX"
const KEY_MENU_MUSIC: String = "MenuMusic"

const SETTINGS_FILE_PATH: String = "user://audio_settings.cfg"

const MASTER_VOLUME_DEFAULT: float = 0.5
const GAME_SFX_VOLUME_DEFAULT: float = 1
const GAME_MUSIC_VOLUME_DEFAULT: float = 1
const MENU_SFX_VOLUME_DEFAULT: float = 1
const MENU_MUSIC_VOLUME_DEFAULT: float = 1

var master_bus_index: int = AudioServer.get_bus_index(KEY_MASTER)
var game_sfx_bus_index: int = AudioServer.get_bus_index(KEY_GAME_SFX)
var game_music_bus_index: int = AudioServer.get_bus_index(KEY_GAME_MUSIC)
var menu_sfx_bus_index: int = AudioServer.get_bus_index(KEY_MENU_SFX)
var menu_music_bus_index: int = AudioServer.get_bus_index(KEY_MENU_MUSIC)


func _ready() -> void:
	load_user()


func set_volume(bus_index: int, value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, value)
	changed.emit()


func save() -> void:
	var config := ConfigFile.new()
	var master_volume: float = AudioServer.get_bus_volume_linear(master_bus_index)
	var game_sfx_volume: float = AudioServer.get_bus_volume_linear(game_sfx_bus_index)
	var game_music_volume: float = AudioServer.get_bus_volume_linear(game_music_bus_index)
	var menu_sfx_volume: float = AudioServer.get_bus_volume_linear(menu_sfx_bus_index)
	var menu_music_volume: float = AudioServer.get_bus_volume_linear(menu_music_bus_index)
	config.set_value(SECTION_VOLUME, KEY_MASTER, master_volume)
	config.set_value(SECTION_VOLUME, KEY_GAME_SFX, game_sfx_volume)
	config.set_value(SECTION_VOLUME, KEY_GAME_MUSIC, game_music_volume)
	config.set_value(SECTION_VOLUME, KEY_MENU_SFX, menu_sfx_volume)
	config.set_value(SECTION_VOLUME, KEY_MENU_MUSIC, menu_music_volume)
	var error: Error = config.save(SETTINGS_FILE_PATH)
	if error == OK:
		saved.emit()


func load_user() -> void:
	var config = ConfigFile.new()
	var error: Error = config.load(SETTINGS_FILE_PATH)
	if error == OK:
		AudioServer.set_bus_volume_linear(master_bus_index, config.get_value(SECTION_VOLUME, KEY_MASTER))
		AudioServer.set_bus_volume_linear(game_sfx_bus_index, config.get_value(SECTION_VOLUME, KEY_GAME_SFX))
		AudioServer.set_bus_volume_linear(game_music_bus_index, config.get_value(SECTION_VOLUME, KEY_GAME_MUSIC))
		AudioServer.set_bus_volume_linear(menu_sfx_bus_index, config.get_value(SECTION_VOLUME, KEY_MENU_SFX))
		AudioServer.set_bus_volume_linear(menu_music_bus_index, config.get_value(SECTION_VOLUME, KEY_MENU_MUSIC))
		loaded_user.emit()
	else:
		load_default()


func load_default() -> void:
	AudioServer.set_bus_volume_linear(master_bus_index, MASTER_VOLUME_DEFAULT)
	AudioServer.set_bus_volume_linear(game_sfx_bus_index, GAME_SFX_VOLUME_DEFAULT)
	AudioServer.set_bus_volume_linear(game_music_bus_index, GAME_MUSIC_VOLUME_DEFAULT)
	AudioServer.set_bus_volume_linear(menu_sfx_bus_index, MENU_SFX_VOLUME_DEFAULT)
	AudioServer.set_bus_volume_linear(menu_music_bus_index, MENU_MUSIC_VOLUME_DEFAULT)
	loaded_default.emit()
