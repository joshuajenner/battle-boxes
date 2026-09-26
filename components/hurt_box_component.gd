class_name HurtBoxComponent
extends Area2D

signal damage_received(amount: int, direction_x: float)
signal knockback_received(direction_x: float)


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		if area.global_position.x > global_position.x:
			damage_received.emit(area.damage, -1)
		else:
			damage_received.emit(area.damage, 1)
		
		if area.has_knockback:
			knockback_received.emit(area.knockback_direction_x)
