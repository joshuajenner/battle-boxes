class_name Lazer
extends HitBoxComponent

@export var animation_player: AnimationPlayer
@export var collision_shape: CollisionShape2D

func _ready() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	self.queue_free()


func set_direction(direction_x: int) -> void:
	if direction_x == 1:
		collision_shape.position.x = 320
	else:
		collision_shape.position.x = -320
