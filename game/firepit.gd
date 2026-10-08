@tool
extends Node2D


@export var particles_amount: int = 256:
	set(value):
		particles_amount = value
		particles.amount = value

@export var particles_width: int = 11:
	set(value):
		particles_width = value
		particles.emission_rect_extents.x = value

@export var detection_area_width: int = 24:
	set(value):
		detection_area_width = value
		var shape := collision_shape_2d.shape as RectangleShape2D
		shape.size.x = value

@export_category("Nodes")
@export var spawn_marker: Marker2D
@export var particles: CPUParticles2D
@export var detection_area: Area2D
@export var collision_shape_2d: CollisionShape2D


func _ready() -> void:
	detection_area.body_entered.connect(on_detection_area_body_entered)


func on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		Player.current.die()
	elif body is Mob:
		body.global_position = spawn_marker.global_position
		body.reset_physics_interpolation()
		body.enter_rage()
