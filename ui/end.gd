extends MarginContainer


@export var replay_button: Button


func _ready() -> void:
	replay_button.pressed.connect(on_replay_button_pressed)


func on_replay_button_pressed() -> void:
	get_tree().reload_current_scene()
