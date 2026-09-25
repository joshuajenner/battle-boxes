extends Weapon

@export var animation_player: AnimationPlayer
@export var hit_box: HitBoxComponent


func setup() -> void:
	hit_box.damage = self.damage


func fire() -> void:
	hit_box.knockback_direction_x = self.direction_x
	animation_player.stop()
	animation_player.play("fire")
