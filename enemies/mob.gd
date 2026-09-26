class_name Mob
extends CharacterBody2D

@export var nav_box: CollisionShape2D
@export var hurt_box: HurtBoxComponent
@export var hit_flash: AnimationPlayer

@export var health_max: int
var health_current: int = 0
@export var move_speed: float = 100
var move_direction: Vector2 = Vector2.ZERO
var is_dead: bool = false


func _ready() -> void:
	move_direction.x = pow(-1, randi() % 2)
	health_current = health_max
	hurt_box.damage_received.connect(on_hurt_box_damage_received)
	hurt_box.knockback_received.connect(on_hurt_box_knockback_received)
	setup()


func setup() -> void:
	pass


func set_direction_x(value: int) -> void:
	move_direction.x = value


func on_hurt_box_damage_received(amount: int, direction_x: float) -> void:
	if is_dead:
		return
	
	health_current -= amount
	hit_flash.play("damage")
	
	if health_current <= 0:
		die(direction_x)


func die(death_direction_x: float) -> void:
	is_dead = true
	velocity.y = -200
	move_direction.x = death_direction_x
	nav_box.set_deferred("disabled", true)
	hurt_box.set_deferred("monitorable", false)
	hit_flash.stop()
	hit_flash.play("die")
	await get_tree().create_timer(5).timeout
	self.queue_free()


func on_hurt_box_knockback_received(direction_x: int) -> void:
	move_direction.x = direction_x
