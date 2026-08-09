extends CharacterBody2D


var move_speed: float = 100


func _ready() -> void:
	pass


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * move_speed

func _physics_process(delta):
	get_input()
	move_and_slide()
