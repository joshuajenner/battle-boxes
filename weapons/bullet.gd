extends Projectile


@onready var sprite: Sprite2D = $Sprite
@export var is_piercing: bool = false
@export var can_bounce: bool = false
@export var can_despawn: bool = false

@export var despawn_timer: Timer = null

func _ready() -> void:
	sprite.flip_h = direction.x < 0
	if despawn_timer != null:
		despawn_timer.start()
		despawn_timer.timeout.connect(on_despawn_timer_timeout)
	area_entered.connect(on_area_entered)
	body_entered.connect(on_body_entered)


func on_despawn_timer_timeout() -> void:
	self.queue_free()


func on_area_entered(area: Area2D) -> void:
	if area is HurtBoxComponent and not is_piercing:
		self.queue_free()


func on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		if can_bounce:
			reverse_direction()
			can_bounce = false
		else:
			self.queue_free()


func reverse_direction() -> void:
	sprite.flip_h = !sprite.flip_h
	direction.x *= -1
