extends Weapon


@export var bullet_scene: PackedScene
@export var muzzle: Marker2D
@export var weapon_audio_player: WeaponAudioPlayer


func fire() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.damage = damage
	bullet.global_position = muzzle.global_position
	bullet.direction_x = direction_x
	projetile_parent_node.add_child(bullet)
	weapon_audio_player.play_random_pitch()
