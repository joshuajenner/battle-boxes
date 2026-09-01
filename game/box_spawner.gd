class_name BoxSpawner
extends Node


@export var spawn_node: Node2D
@export var spawn_areas: Array[CollisionShape2D]


const BOX = preload("uid://d4dm1gyla7h5a")


func _ready() -> void:
	pass


func spawn_box() -> Box:
	var spawn_area: CollisionShape2D = spawn_areas.pick_random()
	var spawn_rect: Rect2 = spawn_area.shape.get_rect()
	var spawn_x: float = randf_range(spawn_rect.position.x, spawn_rect.position.x + spawn_rect.size.x)
	var spawn_position: Vector2 = Vector2(spawn_x, 0) + spawn_area.global_position
	
	var new_box: Node2D = BOX.instantiate()
	new_box.global_position = spawn_position
	spawn_node.call_deferred("add_child", new_box)
	return new_box
