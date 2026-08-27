class_name GameLevel
extends Node


var is_player_on_run: bool = true


func _ready() -> void:
	if not GameData.has_loaded:
		GameData.load_game_data()
	
	GameEvent.player_died.connect(on_player_died)
	GameEvent.crate_picked_up.connect(on_crate_picked_up)
	is_player_on_run = true


func on_player_died() -> void:
	is_player_on_run = false
	GameData.save_game_data()


func on_crate_picked_up() -> void:
	GameData.lifetime_score += 1
	GameData.level_1_high_score += 1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_player_on_run:
			if get_tree().paused:
				GameEvent.game_unpaused.emit()
				get_tree().paused = false
			else:
				GameEvent.game_paused.emit()
				get_tree().paused = true
