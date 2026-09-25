class_name HurtBoxComponent
extends Area2D

signal damage_received(damage: int)
signal knockback_received(direction_x: float)


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		damage_received.emit(area.damage)
		if area.has_knockback:
			knockback_received.emit(area.knockback_direction_x)
