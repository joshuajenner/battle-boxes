extends Control


@export var play_button: Button
@export var settings_button: Button


func _ready() -> void:
	play_button.pressed.connect(on_play_button_pressed)
	settings_button.pressed.connect(on_settings_button_pressed)
	GameData.load_game_data()


func on_play_button_pressed() -> void:
	SceneManager.switch_to(Scenes.LEVEL_SELECT)


func on_settings_button_pressed() -> void:
	SceneManager.switch_to(Scenes.SETTINGS_MENU)
