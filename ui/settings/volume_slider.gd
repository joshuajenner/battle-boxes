class_name VolumeSlider
extends HSlider


@export var audio_bus : StringName
@export var label: Label

var index: int = 0


func _ready() -> void:
	max_value = 1
	step = 0.01
	index = AudioServer.get_bus_index(audio_bus)
	value = AudioServer.get_bus_volume_linear(index)
	set_label(value)
	
	AudioSettings.loaded_user.connect(on_value_loaded)
	AudioSettings.loaded_default.connect(on_value_loaded)
	value_changed.connect(on_value_changed)


func on_value_loaded() -> void:
	value = AudioServer.get_bus_volume_linear(index)
	set_label(value)


func on_value_changed(value: float) -> void:
	AudioSettings.set_volume(index, value)
	set_label(value)


func set_label(value: float) -> void:
	if label != null:
		label.text = str(roundi(value * 100))
