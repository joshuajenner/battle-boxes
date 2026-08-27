extends Control


@export var play_button: Button
@export var settings_button: Button
@export var credits_button: Button
@export var quit_button: Button


func _ready() -> void:
	play_button.pressed.connect(on_play_button_pressed)
	settings_button.pressed.connect(on_settings_button_pressed)
	credits_button.pressed.connect(on_credits_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)
	GameData.load_game_data()


func on_play_button_pressed() -> void:
	SceneManager.switch_to(Scenes.LEVEL_SELECT)


func on_settings_button_pressed() -> void:
	SceneManager.switch_to(Scenes.SETTINGS_MENU)


func on_credits_button_pressed() -> void:
	SceneManager.switch_to(Scenes.CREDITS)


func on_quit_button_pressed() -> void:
	get_tree().quit()
