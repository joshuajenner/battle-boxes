extends Node2D


const ZOMBIE_SCENE = preload("uid://2gliggdm8ayc")
const BIG_ZOMBIE_SCENE = preload("uid://cayvgrrkscxrh")
const GHOST_SCENE = preload("uid://bc51dwypandwn")

@export var timer: Timer

@export var spawn_cooldown_sec: float = 1
@export var is_disabled: bool

var rng = RandomNumberGenerator.new()

enum {
	ONE_ZOMBIE,
	ONE_BIG_ZOMBIE,
	ONE_GHOST,
}

var spawns: Array[int] = [ONE_ZOMBIE, ONE_BIG_ZOMBIE, ONE_GHOST] 
var weights := PackedFloat32Array([0, 0, 1])


func _ready() -> void:
	if is_disabled: return
	timer.start(spawn_cooldown_sec)
	timer.timeout.connect(spawn_enemy)


func spawn_enemy() -> void:
	timer.start(spawn_cooldown_sec)
	var spawn: int = spawns[rng.rand_weighted(weights)]
	match spawn:
		ONE_ZOMBIE:
			add_child(ZOMBIE_SCENE.instantiate())
		ONE_BIG_ZOMBIE:
			add_child(BIG_ZOMBIE_SCENE.instantiate())
		ONE_GHOST:
			add_child(GHOST_SCENE.instantiate())
