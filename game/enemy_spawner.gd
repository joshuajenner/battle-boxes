extends Node2D


const ZOMBIE_SCENE = preload("uid://2gliggdm8ayc")
const BIG_ZOMBIE_SCENE = preload("uid://cayvgrrkscxrh")
const GHOST_SCENE = preload("uid://bc51dwypandwn")

@export var spawn_timer: Timer
@export var triple_timer: Timer

@export var initial_spawn_delay: float = 2
@export var spawn_cooldown_sec: float = 1
@export var is_disabled: bool

var rng = RandomNumberGenerator.new()

enum {
	ONE_ZOMBIE,
	ONE_BIG_ZOMBIE,
	ONE_GHOST,
	TRIPLE_ZOMBIE,
}

var spawns: Array[int] = [ONE_ZOMBIE, ONE_BIG_ZOMBIE, ONE_GHOST, TRIPLE_ZOMBIE] 
var weights := PackedFloat32Array([1, 0.5, 0.5, 0.25])


func _ready() -> void:
	if is_disabled: return
	spawn_timer.start(initial_spawn_delay)
	spawn_timer.timeout.connect(spawn_enemy)


func spawn_enemy() -> void:
	spawn_timer.start(spawn_cooldown_sec)
	var spawn: int = spawns[rng.rand_weighted(weights)]
	match spawn:
		ONE_ZOMBIE:
			add_child(ZOMBIE_SCENE.instantiate())
		ONE_BIG_ZOMBIE:
			add_child(BIG_ZOMBIE_SCENE.instantiate())
		ONE_GHOST:
			add_child(GHOST_SCENE.instantiate())
		TRIPLE_ZOMBIE:
			var direction: int = pow(-1, randi() % 2)
			for i in range(3):
				var zombie = ZOMBIE_SCENE.instantiate()
				add_child(zombie)
				zombie.set_direction(direction)
				triple_timer.start(0.3)
				await triple_timer.timeout
