extends Weapon


@export var bullet_scene: PackedScene
@export var muzzle: Marker2D
@export var weapon_audio: WeaponAudioPlayer
@export var animation_player: AnimationPlayer

@export var bullet_spread: float


func fire() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.damage = damage
	bullet.global_position = muzzle.global_position
	bullet.direction = Vector2(direction_x, 0)
	projetile_parent_node.add_child(bullet)
	weapon_audio.play_random_pitch()
	animation_player.stop()
	animation_player.play("fire")
