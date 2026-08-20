extends RigidBody2D


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is Player:
		GameEvent.crate_picked_up.emit()
		self.queue_free()
