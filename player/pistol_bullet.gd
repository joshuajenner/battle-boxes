extends Area2D


@onready var sprite: Sprite2D = $Sprite


var speed: float = 400
var direction_x: int = 1


func _ready() -> void:
	sprite.flip_h = direction_x < 0


func _physics_process(delta: float) -> void:
	position.x += direction_x * speed * delta
