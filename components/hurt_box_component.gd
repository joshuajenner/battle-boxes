class_name HurtBoxComponent
extends Area2D


signal projectile_entered(damage: int)


func _on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		projectile_entered.emit(area.damage)
