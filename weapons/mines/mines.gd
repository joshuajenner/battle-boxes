extends Weapon

@export var mine_scene: PackedScene
@export var muzzle: Marker2D
@export var animation_player: AnimationPlayer


func fire() -> void:
	animation_player.play("fire")


func drop_mine() -> void:
	# Run in animation_player
	var mine: Mine = mine_scene.instantiate()
	mine.damage = damage
	mine.global_position = muzzle.global_position
	projetile_parent_node.add_child(mine)
