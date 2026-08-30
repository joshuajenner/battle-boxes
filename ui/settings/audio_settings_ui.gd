extends MarginContainer


@export var save_button: Button
@export var cancel_button: Button
@export var reset_button: Button


func _ready() -> void:
	on_audio_settings_no_changes()
	
	save_button.pressed.connect(on_save_button_pressed)
	cancel_button.pressed.connect(on_cancel_button_pressed)
	reset_button.pressed.connect(on_reset_button_pressed)
	AudioSettings.changed.connect(on_audio_settings_changed)
	AudioSettings.loaded_user.connect(on_audio_settings_no_changes)
	AudioSettings.saved.connect(on_audio_settings_no_changes)


func on_save_button_pressed() -> void:
	AudioSettings.save()


func on_cancel_button_pressed() -> void:
	AudioSettings.load_user()


func on_reset_button_pressed() -> void:
	AudioSettings.load_default()


func on_audio_settings_changed() -> void:
	cancel_button.disabled = false
	save_button.disabled = false


func on_audio_settings_no_changes() -> void:
	save_button.disabled = true
	cancel_button.disabled = true
