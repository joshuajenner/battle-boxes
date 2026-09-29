extends Weapon

@export var flame_particles: CPUParticles2D
@export var flame_bolt_scene: PackedScene
@export var muzzle: Marker2D
@export var animation_player: AnimationPlayer

var velocity := Vector2(200, 0)
var velocity_min := Vector2(200, 0)
var velocity_step := Vector2(50, 0)
var velocity_max := Vector2(500, 0)

func setup() -> void:
	flame_particles.emitting = false


func fire() -> void:
	var flame_bolt: FlameBolt = flame_bolt_scene.instantiate()
	flame_bolt.global_position = muzzle.global_position
	if velocity < velocity_max:
		velocity += velocity_step
	flame_bolt.linear_velocity = Vector2(velocity.x * direction_x, velocity.y)
	projetile_parent_node.add_child(flame_bolt)
	animation_player.stop()
	animation_player.play("fire")


func start_firing() -> void:
	flame_particles.emitting = true
	velocity = velocity_min


func stop_firing() -> void:
	flame_particles.emitting = false
