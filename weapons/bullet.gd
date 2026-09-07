extends Projectile


@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	sprite.flip_h = direction.x < 0
	area_entered.connect(on_area_entered)
	body_entered.connect(on_body_entered)


func on_area_entered(area: Area2D) -> void:
	if area is HurtBoxComponent:
		self.queue_free()


func on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		self.queue_free()
