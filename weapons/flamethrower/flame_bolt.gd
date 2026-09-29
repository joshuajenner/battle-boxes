class_name FlameBolt
extends RigidBody2D

@export var despawn_timer: Timer
@export var damage_tick: Timer
@export var detection_area: Area2D

func _ready() -> void:
	despawn_timer.timeout.connect(on_despawn_timer_timeout)
	damage_tick.timeout.connect(on_damage_tick_timeout)


func on_damage_tick_timeout() -> void:
	var areas: Array[Area2D] = detection_area.get_overlapping_areas()
	for area in areas:
		if area is HurtBoxComponent:
			area.take_damage(2, self.global_position)


func on_despawn_timer_timeout() -> void:
	self.queue_free()
