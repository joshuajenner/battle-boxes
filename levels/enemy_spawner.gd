extends Node2D


@export var zombie: PackedScene

@export var timer: Timer

@export var spawn_cooldown_sec: float


func _ready() -> void:
	timer.start(spawn_cooldown_sec)
	timer.timeout.connect(spawn_zombie)


func spawn_zombie() -> void:
	timer.start(spawn_cooldown_sec)
	add_child(zombie.instantiate())
