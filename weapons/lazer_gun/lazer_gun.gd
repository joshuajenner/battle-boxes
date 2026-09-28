extends Weapon

@export var lazer_scene: PackedScene
@export var muzzle: Marker2D
@export var animation_player: AnimationPlayer
@export var charging_hitbox: HitBoxComponent


func setup() -> void:
	charging_hitbox.damage = damage


func fire() -> void:
	animation_player.play("fire")


func spawn_lazer() -> void:
	# Run in animation player
	var lazer: Lazer = lazer_scene.instantiate()
	lazer.set_direction(direction_x)
	lazer.damage = damage
	lazer.global_position = muzzle.global_position
	projetile_parent_node.add_child(lazer)
