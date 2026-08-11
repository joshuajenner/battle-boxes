extends CharacterBody2D


var move_speed: float = 200
var jump_speed: float = -400


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_speed
	
	var input_direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = input_direction * move_speed
	move_and_slide()
