extends Projectile


@export var explosion_hitbox: HitBoxComponent
@export var animation_player: AnimationPlayer


func setup() -> void:
	explosion_hitbox.damage = self.damage


func on_area_entered(area: Area2D) -> void:
	if area is HurtBoxComponent and not is_piercing:
		explode()


func on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		explode()


func explode() -> void:
	speed = 0
	animation_player.play("explode")
	await animation_player.animation_finished
	self.queue_free()
