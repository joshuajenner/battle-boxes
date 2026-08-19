class_name HealthComponent
extends Node


signal health_depleted


@export var max_health: int
var current_health: int = 0


func _ready() -> void:
	current_health = max_health


func take_damage(damage_value: int) -> void:
	current_health -= damage_value
	if current_health <= 0:
		health_depleted.emit()
