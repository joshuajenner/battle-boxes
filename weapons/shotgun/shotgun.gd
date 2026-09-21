extends Weapon


@export var bullet_scene: PackedScene
@export var muzzle: Marker2D
@export var weapon_audio: WeaponAudioPlayer
@export var animation_player: AnimationPlayer

@export var pellets_per_shot: int
@export var pellet_spread: float

var rng = RandomNumberGenerator.new()


func fire() -> void:
	for i in range(pellets_per_shot):
		var bullet: Node2D = bullet_scene.instantiate()
		bullet.damage = damage
		bullet.global_position = muzzle.global_position
		bullet.direction = Vector2(direction_x, 
				rng.randf_range(-pellet_spread, pellet_spread))
		projetile_parent_node.add_child(bullet)
	weapon_audio.play_random_pitch()
	animation_player.stop()
	animation_player.play("fire")
