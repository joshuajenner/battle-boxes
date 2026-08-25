extends Node


@export var game_hud_ui: GameHUDUI
@export var game_end_ui: GameEndUI
@export var game_pause_ui: GamePauseUI


func _ready() -> void:
	GameEvent.crate_picked_up.connect(game_hud_ui.increase_score)
	GameEvent.player_died.connect(show_game_end_ui)
	GameEvent.game_paused.connect(show_game_pause_ui)
	GameEvent.game_unpaused.connect(hide_game_pause_ui)
	
	game_hud_ui.visible = true
	game_end_ui.visible = false
	game_pause_ui.visible = false


func show_game_end_ui() -> void:
	game_end_ui.visible = true


func show_game_pause_ui() -> void:
	game_pause_ui.visible = true


func hide_game_pause_ui() -> void:
	game_pause_ui.visible = false
