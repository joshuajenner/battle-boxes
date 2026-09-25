extends CharacterBody2D


@export var body_sprite: Sprite2D
@export var bounce_timer: Timer
@export var hurt_box_component: HurtBoxComponent
@export var health_component: HealthComponent
@export var hit_flash_player: AnimationPlayer
@export var nav_box: CollisionShape2D

const BOUNCE_TIME_SEC: float = 2

var move_speed: int = 40
var move_direction: int = 1
var gravity_ratio: float = 0.02
var max_bounce_speed: float = -40
var min_bounce_speed: float = -10
var is_dead: bool = false

var player: Player = null
var rng := RandomNumberGenerator.new()


func _ready() -> void:
	move_direction = roundi(pow(-1, randi() % 2))
	player = Player.current
	bounce_timer.timeout.connect(on_bounce_timer_timeout)
	hurt_box_component.damage_received.connect(on_hurt_box_damage_received)
	health_component.health_depleted.connect(on_health_depleted)


func _physics_process(delta: float) -> void:
	if is_dead:
		velocity += get_gravity() * delta
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity += get_gravity() * gravity_ratio * delta
	else:
		velocity.y += rng.randf_range(max_bounce_speed, min_bounce_speed)
		bounce_timer.start(BOUNCE_TIME_SEC)
	
	if is_on_wall():
		move_direction = -move_direction
		bounce_timer.start(BOUNCE_TIME_SEC)
	
	velocity.x = move_direction * move_speed
	handle_animation()
	move_and_slide()


func handle_animation() -> void:
	if global_position.x < player.global_position.x:
		body_sprite.frame = 0
	else:
		body_sprite.frame = 1


func on_hurt_box_damage_received(damage: int) -> void:
	health_component.take_damage(damage)
	hit_flash_player.play("flash")


func on_health_depleted() -> void:
	is_dead = true
	move_direction = -move_direction
	velocity.y = -200
	nav_box.set_deferred("disabled", true)
	bounce_timer.stop()
	await get_tree().create_timer(5).timeout
	self.queue_free()


func on_bounce_timer_timeout() -> void:
	var y_diff: int = abs(global_position.y - player.global_position.y)
	if y_diff < 32:
		if global_position.x > player.global_position.x:
			move_direction = -1
		else:
			move_direction = 1
