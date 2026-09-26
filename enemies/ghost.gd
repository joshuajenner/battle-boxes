extends Mob

@export var body_sprite: Sprite2D
@export var bounce_timer: Timer

const BOUNCE_TIME_SEC: float = 2

var gravity_ratio: float = 0.02
var max_bounce_speed: float = -40
var min_bounce_speed: float = -10

var player: Player = null
var rng := RandomNumberGenerator.new()


func setup() -> void:
	player = Player.current
	bounce_timer.timeout.connect(on_bounce_timer_timeout)


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
	
	velocity.x = move_direction.x * move_speed
	handle_animation()
	move_and_slide()


func handle_animation() -> void:
	if global_position.x < player.global_position.x:
		body_sprite.frame = 0
	else:
		body_sprite.frame = 1


func on_bounce_timer_timeout() -> void:
	var y_diff: int = abs(global_position.y - player.global_position.y)
	if y_diff < 32:
		if global_position.x > player.global_position.x:
			move_direction.x = -1
		else:
			move_direction.x = 1
