class_name GameManager
extends Node


var is_player_on_run: bool = true


func _ready() -> void:
	GameEvent.player_died.connect(on_player_died)
	is_player_on_run = true


func on_player_died() -> void:
	is_player_on_run = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_player_on_run:
			if get_tree().paused:
				GameEvent.game_unpaused.emit()
				get_tree().paused = false
			else:
				GameEvent.game_paused.emit()
				get_tree().paused = true
