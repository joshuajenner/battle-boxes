extends CharacterBody2D


@onready var hit_flash_player: AnimationPlayer = $HitFlashPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var nav_box: CollisionShape2D = $NavBox
@onready var delete_after_death: Timer = $DeleteAfterDeath

@export var hurt_box_component: HurtBoxComponent
@export var health_component: HealthComponent

@export var move_speed: float = 100
var direction: int = 1
var is_dead: bool = false

func _ready() -> void:
	direction = pow(-1, randi() % 2)
	hurt_box_component.damage_received.connect(on_hurt_box_damage_received)
	hurt_box_component.knockback_received.connect(on_hurt_box_knockback_received)
	health_component.health_depleted.connect(on_health_component_health_depleted)
	delete_after_death.timeout.connect(on_delete_after_death_timeout)


func set_direction(value: int) -> void:
	direction = value


func _physics_process(delta: float) -> void:
	if is_dead:
		velocity += get_gravity() * delta
		velocity.x = direction * move_speed
		move_and_slide()
		return
	
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


func on_hurt_box_damage_received(damage: int) -> void:
	if not is_dead:
		health_component.take_damage(damage)
		hit_flash_player.play("flash")


func on_hurt_box_knockback_received(direction_x: int) -> void:
	direction = direction_x


func on_health_component_health_depleted() -> void:
	is_dead = true
	velocity.y = -200
	direction = -direction
	nav_box.set_deferred("disabled", true)
	await get_tree().create_timer(5).timeout
	self.queue_free()


func on_delete_after_death_timeout() -> void:
	self.queue_free()
