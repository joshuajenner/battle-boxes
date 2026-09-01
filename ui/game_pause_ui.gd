class_name GamePauseUI
extends CanvasLayer


@export var resume_button: Button
@export var settings_button: Button
@export var quit_button: Button
@export var settings_back_button: Button

@export var menu_container: Container
@export var settings_container: Container


func _ready() -> void:
	resume_button.pressed.connect(on_resume_button_pressed)
	settings_button.pressed.connect(show_settings)
	quit_button.pressed.connect(on_quit_button_pressed)
	settings_back_button.pressed.connect(on_settings_back_button_pressed)
	show_menu()


func show_menu() -> void:
	menu_container.visible = true
	settings_container.visible = false


func show_settings() -> void:
	menu_container.visible = false
	settings_container.visible = true


func on_resume_button_pressed() -> void:
	get_tree().paused = false
	self.visible = false


func on_quit_button_pressed() -> void:
	SceneManager.switch_to(Scenes.LEVEL_SELECT)


func on_settings_back_button_pressed() -> void:
	VideoSettings.save()
	AudioSettings.save()
	show_menu()
