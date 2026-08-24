class_name GameUI
extends CanvasLayer


@export var hud: HUD
@export var game_end: Control

func _ready() -> void:
	GameEvent.crate_picked_up.connect(hud.increase_score)
	GameEvent.player_died.connect(show_game_end)
	hud.visible = true
	game_end.visible = false


func show_game_end() -> void:
	game_end.visible = true
