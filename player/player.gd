class_name Player
extends CharacterBody2D


@onready var body_sprite: Sprite2D = $BodySprite
@onready var weapon_sprite: Sprite2D = $Weapon/WeaponSprite
@onready var weapon: Node2D = $Weapon
@onready var muzzle: Marker2D = $Weapon/Muzzle


const PISTOL_BULLET = preload("uid://dpykyiq83n7vr")


var move_speed: float = 180
var jump_speed: float = -400
var direction_x: float = 1


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = jump_speed
	
	var input_direction: float = Input.get_axis("move_left", "move_right")
	direction_x = input_direction if input_direction != 0 else direction_x
	velocity.x = input_direction * move_speed
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		var bullet: Node2D = PISTOL_BULLET.instantiate()
		bullet.global_position = muzzle.global_position
		bullet.direction_x = direction_x
		get_parent().add_child(bullet)
	
	handle_animation()


func handle_animation() -> void:
	var is_looking_left: bool = direction_x < 0
	body_sprite.flip_h = is_looking_left
	weapon.scale.x = -1 if is_looking_left else 1
