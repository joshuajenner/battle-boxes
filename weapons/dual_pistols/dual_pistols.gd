extends Weapon


@export var bullet_scene: PackedScene
@export var muzzle_right: Marker2D
@export var muzzle_left: Marker2D
@export var right_animation_player: AnimationPlayer
@export var left_animation_player: AnimationPlayer


func fire() -> void:
	var bullet_right: Node2D = bullet_scene.instantiate()
	var bullet_left: Node2D = bullet_scene.instantiate()
	bullet_right.damage = damage
	bullet_left.damage = damage
	bullet_right.direction.x = 1
	bullet_left.direction.x = -1
	bullet_right.global_position = muzzle_right.global_position
	bullet_left.global_position = muzzle_left.global_position
	right_animation_player.stop()
	left_animation_player.stop()
	right_animation_player.play("fire")
	left_animation_player.play("fire")
	projetile_parent_node.add_child(bullet_right)
	projetile_parent_node.add_child(bullet_left)
