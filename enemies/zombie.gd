extends CharacterBody2D


@onready var hit_flash_player: AnimationPlayer = $HitFlashPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var hurt_box_component: HurtBoxComponent
@export var health_component: HealthComponent

@export var move_speed: float = 100
var direction: int = 1


func _ready() -> void:
	direction = pow(-1, randi() % 2)
	hurt_box_component.projectile_entered.connect(on_hurt_box_component_projectile_entered)
	health_component.health_depleted.connect(on_health_component_health_depleted)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		direction = -direction
	
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


func on_hurt_box_component_projectile_entered(damage: int) -> void:
	health_component.take_damage(damage)
	hit_flash_player.play("flash")


func on_health_component_health_depleted() -> void:
	self.queue_free()
