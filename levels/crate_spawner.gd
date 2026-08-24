extends Node


@export var spawn_node: Node2D
@export var spawn_areas: Array[CollisionShape2D]


const CRATE = preload("uid://d4dm1gyla7h5a")


func _ready() -> void:
	GameEvent.crate_picked_up.connect(spawn_crate)


func spawn_crate() -> void:
	var spawn_area: CollisionShape2D = spawn_areas.pick_random()
	var spawn_rect: Rect2 = spawn_area.shape.get_rect()
	var spawn_x: float = randf_range(spawn_rect.position.x, spawn_rect.position.x + spawn_rect.size.x)
	var spawn_position: Vector2 = Vector2(spawn_x, 0) + spawn_area.global_position
	
	var new_crate: Node2D = CRATE.instantiate()
	new_crate.global_position = spawn_position
	spawn_node.call_deferred("add_child", new_crate)
