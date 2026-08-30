class_name WeaponAudioPlayer
extends AudioStreamPlayer2D


@export var pitch_scale_min: float = 1.0
@export var pitch_scale_max: float = 1.0

var rng = RandomNumberGenerator.new()


func play_random_pitch() -> void:
	pitch_scale = rng.randf_range(pitch_scale_min, pitch_scale_max)
	play()
