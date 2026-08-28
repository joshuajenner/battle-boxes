extends TabContainer


@export var save_button: Button
@export var cancel_button: Button
@export var reset_button: Button


func _ready() -> void:
	on_video_settings_no_changes()
	
	save_button.pressed.connect(on_save_button_pressed)
	cancel_button.pressed.connect(on_cancel_button_pressed)
	reset_button.pressed.connect(on_reset_button_pressed)
	VideoSettings.changed.connect(on_video_settings_changed)
	VideoSettings.loaded_user.connect(on_video_settings_no_changes)
	VideoSettings.saved.connect(on_video_settings_no_changes)


func on_save_button_pressed() -> void:
	VideoSettings.save()


func on_cancel_button_pressed() -> void:
	VideoSettings.load_user()


func on_reset_button_pressed() -> void:
	VideoSettings.load_default()


func on_video_settings_changed() -> void:
	cancel_button.disabled = false
	save_button.disabled = false


func on_video_settings_no_changes() -> void:
	save_button.disabled = true
	cancel_button.disabled = true
