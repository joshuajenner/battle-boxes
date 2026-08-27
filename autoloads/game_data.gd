class_name GameData
extends Object


const SECTION_SCORE: String = "score"
const KEY_LIFETIME: String = "lifetime"
const KEY_LEVEL_1: String = "level_1"

const GAME_SAVE_FILE_PATH: String = "user://game_save.cfg"


static var selected_level_index: int = 0
static var lifetime_score: int = 0
static var level_1_high_score: int = 0

static var has_loaded: bool = false


static func save_game_data() -> void:
	var config := ConfigFile.new()
	config.set_value(SECTION_SCORE, KEY_LIFETIME, lifetime_score)
	config.set_value(SECTION_SCORE, KEY_LEVEL_1, level_1_high_score)
	config.save(GAME_SAVE_FILE_PATH)


static func load_game_data() -> void:
	var config = ConfigFile.new()
	var err = config.load(GAME_SAVE_FILE_PATH)
	if err == OK:
		has_loaded = true
		lifetime_score = config.get_value(SECTION_SCORE, KEY_LIFETIME)
		level_1_high_score = config.get_value(SECTION_SCORE, KEY_LEVEL_1)
