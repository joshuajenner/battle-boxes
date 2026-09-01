class_name GameManager
extends Node


@export var box_spawner: BoxSpawner
@export var game_hud_ui: GameHUDUI
@export var game_end_ui: GameEndUI
@export var game_pause_ui: CanvasLayer


var is_player_on_run: bool = true
var player: Player = null


func _ready() -> void:
	if not GameData.has_loaded:
		GameData.load_game_data()
	
	player = Player.current
	is_player_on_run = true
	game_end_ui.visible = false
	game_pause_ui.visible = false
	
	spawn_box()
	
	player.died.connect(on_player_died)


func spawn_box() -> void:
	var box: Box = box_spawner.spawn_box()
	box.picked_up.connect(on_box_picked_up)


func on_box_picked_up() -> void:
	GameData.lifetime_score += 1
	GameData.level_1_high_score += 1
	game_hud_ui.increase_score()
	spawn_box()


func on_player_died() -> void:
	is_player_on_run = false
	game_end_ui.visible = true
	GameData.save_game_data()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_player_on_run:
			if get_tree().paused:
				game_pause_ui.visible = false
				get_tree().paused = false
			else:
				game_pause_ui.visible = true
				get_tree().paused = true
