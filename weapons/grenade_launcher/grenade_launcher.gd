extends Weapon

@export var grenade_scene: PackedScene
@export var muzzle: Marker2D
@export var animation_player: AnimationPlayer

var velocity := Vector2(450, -150)

func fire() -> void:
	var grenade_scene: Grenade = grenade_scene.instantiate()
	grenade_scene.damage = damage
	grenade_scene.global_position = muzzle.global_position
	grenade_scene.linear_velocity = Vector2(velocity.x * direction_x, velocity.y)
	projetile_parent_node.add_child(grenade_scene)
	animation_player.stop()
	animation_player.play("fire")
