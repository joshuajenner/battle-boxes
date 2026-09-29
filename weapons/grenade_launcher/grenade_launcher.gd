extends Weapon

@export var grenade_scene: PackedScene
@export var muzzle: Marker2D
@export var animation_player: AnimationPlayer

var velocity := Vector2(450, -150)

func fire() -> void:
	var grenade: Grenade = grenade_scene.instantiate()
	grenade.damage = damage
	grenade.global_position = muzzle.global_position
	grenade.linear_velocity = Vector2(velocity.x * direction_x, velocity.y)
	projetile_parent_node.add_child(grenade)
	animation_player.stop()
	animation_player.play("fire")
