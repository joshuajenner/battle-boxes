class_name GamePauseUI
extends CanvasLayer


@export var resume_button: Button


func _ready() -> void:
	resume_button.pressed.connect(on_resume_button_pressed)


func on_resume_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false
