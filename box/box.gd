class_name Box
extends RigidBody2D


signal picked_up()


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is Player:
		picked_up.emit()
		self.queue_free()
