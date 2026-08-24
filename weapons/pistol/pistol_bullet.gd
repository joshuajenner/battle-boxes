extends Projectile


@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	sprite.flip_h = direction_x < 0


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBoxComponent:
		self.queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		self.queue_free()
