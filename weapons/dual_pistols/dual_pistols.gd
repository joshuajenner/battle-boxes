extends Weapon


@export var bullet_scene: PackedScene
@export var muzzle_right: Marker2D
@export var muzzle_left: Marker2D


func fire() -> void:
	var bullet_right: Node2D = bullet_scene.instantiate()
	var bullet_left: Node2D = bullet_scene.instantiate()
	bullet_right.damage = damage
	bullet_left.damage = damage
	bullet_right.direction_x = 1
	bullet_left.direction_x = -1
	bullet_right.global_position = muzzle_right.global_position
	bullet_left.global_position = muzzle_left.global_position
	projetile_parent_node.add_child(bullet_right)
	projetile_parent_node.add_child(bullet_left)
