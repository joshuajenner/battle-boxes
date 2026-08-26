class_name GameEndUI
extends CanvasLayer


@export var replay_button: Button
@export var quit_button: Button


func _ready() -> void:
	replay_button.pressed.connect(on_replay_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)


func on_replay_button_pressed() -> void:
	SceneManager.reload_current_scene()


func on_quit_button_pressed() -> void:
	SceneManager.switch_to(Scenes.LEVEL_SELECT)
