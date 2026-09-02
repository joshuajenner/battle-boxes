extends MarginContainer


@export var play_level_1_button: Button
@export var level_1_highscore_label: Label
@export var back_button: Button


func _ready() -> void:
	level_1_highscore_label.text = "Highscore: " + str(GameSave.level_1_high_score)
	
	play_level_1_button.pressed.connect(on_play_level_1_button_pressed)
	back_button.pressed.connect(on_back_button_pressed)


func on_play_level_1_button_pressed() -> void:
	SceneManager.switch_to(Scenes.GAME_LEVEL)


func on_back_button_pressed() -> void:
	SceneManager.switch_to(Scenes.MAIN_MENU)
