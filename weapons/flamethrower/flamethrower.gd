extends Weapon

@export var flame_particles: CPUParticles2D
@export var flame_bolt_scene: PackedScene
@export var muzzle: Marker2D
@export var animation_player: AnimationPlayer

var velocity_x_min: float = 200.0
var velocity_x_max: float = 500.0

var rng := RandomNumberGenerator.new()


func setup() -> void:
	flame_particles.emitting = false


func fire() -> void:
	var flame_bolt: FlameBolt = flame_bolt_scene.instantiate()
	flame_bolt.global_position = muzzle.global_position
	var velocity_x: float = rng.randf_range(velocity_x_min, velocity_x_max)
	flame_bolt.linear_velocity = Vector2(velocity_x * direction_x, 0)
	projetile_parent_node.add_child(flame_bolt)
	animation_player.stop()
	animation_player.play("fire")


func start_firing() -> void:
	flame_particles.emitting = true


func stop_firing() -> void:
	flame_particles.emitting = false
