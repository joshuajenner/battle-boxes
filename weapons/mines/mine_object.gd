class_name Mine
extends RigidBody2D

enum Frames {
	UNARMED = 0,
	ARMED = 1,
}

@export var body_sprite: Sprite2D
@export var detect_area: Area2D
@export var hit_box: HitBoxComponent
@export var explosion_shape: CollisionShape2D
@export var animation_player: AnimationPlayer
@export var arm_timer: Timer

var damage: int = 0
var is_armed: bool = false


func _ready() -> void:
	body_sprite.frame = Frames.UNARMED
	hit_box.damage = damage
	detect_area.body_entered.connect(on_detect_area_body_entered)
	arm_timer.timeout.connect(on_arm_timer_timeout)


func on_arm_timer_timeout() -> void:
	body_sprite.frame = Frames.ARMED
	is_armed = true


func on_detect_area_body_entered(_body: Node2D) -> void:
	if is_armed:
		animation_player.play("explode")
		await animation_player.animation_finished
		self.queue_free()
