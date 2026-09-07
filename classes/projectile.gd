class_name Projectile
extends Area2D


@export var speed: float
@export var damage: int

var direction := Vector2.ZERO


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func set_direction_x(x_value: int) -> void:
	if x_value == 1 or x_value == -1:
		direction.x = x_value
