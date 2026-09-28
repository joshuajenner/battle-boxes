class_name Grenade
extends RigidBody2D

@export var detect_area: Area2D
@export var hit_box: HitBoxComponent
@export var animation_player: AnimationPlayer
@export var explode_timer: Timer

var damage: int = 0

func _ready() -> void:
	hit_box.damage = damage
	detect_area.body_entered.connect(on_detect_area_body_entered)
	explode_timer.timeout.connect(explode)


func on_detect_area_body_entered(body: Node2D) -> void:
	explode()


func explode() -> void:
	set_deferred("freeze", true)
	animation_player.play("explode")
	await animation_player.animation_finished
	self.queue_free()
