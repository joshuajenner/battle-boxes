extends CharacterBody2D


@onready var body_sprite: Sprite2D = $BodySprite
@onready var hit_flash_player: AnimationPlayer = $HitFlashPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var health_component: HealthComponent

var health: int = 10
var move_speed: float = 100
var direction: int = 1


func _ready() -> void:
	set_direction(pow(-1, randi() % 2))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		set_direction(-direction)
	
	velocity.x = direction * move_speed
	handle_animation()
	move_and_slide()


func handle_animation() -> void:
	if direction >= 0:
		if is_on_floor():
			animation_player.play("walk_right")
		else:
			animation_player.play("fall_right")
	else:
		if is_on_floor():
			animation_player.play("walk_left")
		else:
			animation_player.play("fall_left")



func set_direction(value: int) -> void:
	direction = value


func _on_hurt_box_component_projectile_entered(damage: int) -> void:
	health_component.take_damage(damage)
	hit_flash_player.play("flash_red")


func _on_health_component_health_depleted() -> void:
	self.queue_free()
