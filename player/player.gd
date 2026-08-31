class_name Player
extends CharacterBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var weapon: Weapon

var move_speed: float = 180
var jump_speed: float = -400
var direction_x: float = 1
var is_dead: bool = false


func _ready() -> void:
	weapon.set_projetile_parent_node(get_parent())


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	if is_on_floor():
		if Input.is_action_just_pressed("move_up"):
			velocity.y = jump_speed
	elif velocity.y < 0.0:
		if Input.is_action_just_released("move_up"):
			velocity.y *= 0.8
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_direction: float = Input.get_axis("move_left", "move_right")
	direction_x = input_direction if input_direction != 0 else direction_x
	weapon.set_direction(direction_x)
	velocity.x = input_direction * move_speed
	move_and_slide()
	handle_animation(input_direction, direction_x)


func handle_animation(input_direction: float, current_direction: float) -> void:
	if is_on_floor():
		if input_direction > 0:
			animation_player.play("walk_right")
		elif input_direction < 0:
			animation_player.play("walk_left")
		else:
			if current_direction >= 0:
				animation_player.play("idle_right")
			else:
				animation_player.play("idle_left")
	else:
		if current_direction >= 0:
			animation_player.play("jump_right")
		else:
			animation_player.play("jump_left")


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		is_dead = true
		GameEvent.player_died.emit()
