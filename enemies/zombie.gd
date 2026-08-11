extends CharacterBody2D


@onready var body_sprite: Sprite2D = $BodySprite


var move_speed: float = 75
var direction: int = 1


func _ready() -> void:
	set_direction(pow(-1, randi() % 2))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		set_direction(-direction)
	
	velocity.x = direction * move_speed
	move_and_slide()


func set_direction(value: int) -> void:
	direction = value
	body_sprite.flip_h = value == -1
