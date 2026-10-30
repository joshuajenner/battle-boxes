extends Node


signal loaded()


const SECTION_SCORE: String = "score"
const KEY_LEVEL_1: String = "level_1"
const KEY_LEVEL_2: String = "level_2"
const KEY_LEVEL_3: String = "level_3"

const GAME_SAVE_FILE_PATH: String = "user://game_save.cfg"


var level_1_high_score: int = 0
var level_2_high_score: int = 0
var level_3_high_score: int = 0


func _ready() -> void:
	load_save()


func save() -> void:
	var config := ConfigFile.new()
	config.set_value(SECTION_SCORE, KEY_LEVEL_1, level_1_high_score)
	config.set_value(SECTION_SCORE, KEY_LEVEL_2, level_2_high_score)
	config.set_value(SECTION_SCORE, KEY_LEVEL_3, level_3_high_score)
	config.save(GAME_SAVE_FILE_PATH)


func load_save() -> void:
	var config = ConfigFile.new()
	var err = config.load(GAME_SAVE_FILE_PATH)
	if err == OK:
		level_1_high_score = config.get_value(SECTION_SCORE, KEY_LEVEL_1)
		level_2_high_score = config.get_value(SECTION_SCORE, KEY_LEVEL_2)
		level_3_high_score = config.get_value(SECTION_SCORE, KEY_LEVEL_3)
		loaded.emit()


func try_save_score(new_score: int, level_index: int) -> void:
	match level_index:
		0:
			if new_score > level_1_high_score:
				level_1_high_score = new_score
				save()
		1:
			if new_score > level_2_high_score:
				level_2_high_score = new_score
				save()
		2:
			if new_score > level_3_high_score:
				level_3_high_score = new_score
				save()
