extends Mob

@export var animation_player: AnimationPlayer


func _physics_process(delta: float) -> void:
	if is_dead:
		velocity += get_gravity() * delta
		velocity.x = move_direction.x * move_speed
		move_and_slide()
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_wall():
		move_direction.x = -move_direction.x
	
	velocity.x = move_direction.x * move_speed
	handle_animation()
	move_and_slide()


func handle_animation() -> void:
	if move_direction.x  >= 0:
		if is_on_floor():
			animation_player.play("walk_right")
		else:
			animation_player.play("fall_right")
	else:
		if is_on_floor():
			animation_player.play("walk_left")
		else:
			animation_player.play("fall_left")
