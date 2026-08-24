extends Weapon


@export var bullet_scene: PackedScene
@export var muzzle: Marker2D


func fire() -> void:
	var bullet: Node2D = bullet_scene.instantiate()
	bullet.global_position = muzzle.global_position
	bullet.direction_x = direction_x
	projetile_parent_node.add_child(bullet)
