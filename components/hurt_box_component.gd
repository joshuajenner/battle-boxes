class_name HurtBoxComponent
extends Area2D


signal projectile_entered(damage: int)


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D) -> void:
	if area is Projectile:
		projectile_entered.emit(area.damage)
