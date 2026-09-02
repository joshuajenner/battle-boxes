class_name GameManager
extends Node


@export var box_spawner: BoxSpawner
@export var game_hud_ui: GameHUDUI
@export var game_end_ui: GameEndUI
@export var game_pause_ui: CanvasLayer


var is_game_over: bool = false
var player: Player = null


func _ready() -> void:
	player = Player.current
	is_game_over = false
	game_end_ui.visible = false
	game_pause_ui.visible = false
	
	spawn_box()
	
	player.died.connect(on_player_died)


func spawn_box() -> void:
	var box: Box = box_spawner.spawn_box()
	box.picked_up.connect(on_box_picked_up)


func on_box_picked_up() -> void:
	GameSave.lifetime_score += 1
	GameSave.level_1_high_score += 1
	game_hud_ui.increase_score()
	player.set_weapon(get_new_weapon(player.weapon.type))
	spawn_box()


func get_new_weapon(previous_weapon: Weapon.Type) -> String:
	var all_weapons: Array[Weapon.Type] = GameData.weapons.duplicate()
	all_weapons.erase(previous_weapon)
	var weapon_definition = GameData.WEAPONS_LIST[all_weapons.pick_random()]
	return weapon_definition.path


func on_player_died() -> void:
	is_game_over = true
	game_end_ui.visible = true
	GameSave.save()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not is_game_over:
		if get_tree().paused:
			game_pause_ui.visible = false
			get_tree().paused = false
		else:
			game_pause_ui.visible = true
			get_tree().paused = true
