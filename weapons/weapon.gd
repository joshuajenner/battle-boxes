class_name Weapon
extends Node2D


@export var fire_rate_timer: Timer
@export var fire_rate_sec: float
@export var is_directional: bool
@export var damage: int

var projetile_parent_node: Node2D
var direction_x: float


func _ready() -> void:
	fire_rate_timer.autostart = false
	fire_rate_timer.one_shot = true


func _physics_process(_delta: float) -> void:
	if is_directional:
		scale.x = direction_x
	
	if Input.is_action_pressed("fire"):
		if fire_rate_timer.is_stopped():
			fire()
			fire_rate_timer.start(fire_rate_sec)


func set_direction(value: float) -> void:
	if value != 0:
		direction_x = value


func fire() -> void:
	pass


func set_projetile_parent_node(node: Node2D) -> void:
	projetile_parent_node = node
