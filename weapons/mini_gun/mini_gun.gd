extends Weapon


@export var bullet_scene: PackedScene
@export var muzzle: Marker2D
@export var weapon_audio: WeaponAudioPlayer
@export var animation_player: AnimationPlayer

@export var bullet_spread_up: float
@export var bullet_spread_down: float

var rng = RandomNumberGenerator.new()


func fire() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.damage = damage
	bullet.global_position = muzzle.global_position
	bullet.direction = Vector2(direction_x, 
	rng.randf_range(-bullet_spread_up, bullet_spread_down))
	projetile_parent_node.add_child(bullet)
	weapon_audio.play_random_pitch()
	animation_player.stop()
	animation_player.play("fire")
