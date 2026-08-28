extends MarginContainer


@export var back_button: Button


func _ready() -> void:
	back_button.pressed.connect(on_back_button_pressed)


func on_back_button_pressed() -> void:
	#Settings.save_settings()
	SceneManager.switch_to(Scenes.MAIN_MENU)
