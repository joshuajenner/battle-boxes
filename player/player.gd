class_name Player
extends CharacterBody2D


@onready var body_sprite: Sprite2D = $BodySprite
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
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_speed
	
	var input_direction: float = Input.get_axis("move_left", "move_right")
	direction_x = input_direction if input_direction != 0 else direction_x
	weapon.set_direction(direction_x)
	velocity.x = input_direction * move_speed
	move_and_slide()
	handle_animation()


func handle_animation() -> void:
	var is_looking_left: bool = direction_x < 0
	body_sprite.flip_h = is_looking_left


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		is_dead = true
		GameEvent.player_died.emit()
