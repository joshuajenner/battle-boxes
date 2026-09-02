extends Node


const WEAPONS_LIST: Dictionary = {
	Weapon.Type.PISTOL: {
		"name": "Pistol",
		"path": "uid://dvq8ltolgnx3c"
	},
	Weapon.Type.DUAL_PISTOLS: {
		"name": "Pistols Akimbo",
		"path": "uid://dgn1vll41vjy5"
	},
	Weapon.Type.REVOLVER: {
		"name": "Revolver",
		"path": "uid://yb8xf8h3it3q"
	},
}


var weapons: Array[Weapon.Type] = []


func _ready() -> void:
	init_unlocks(GameSave.lifetime_score)
	
	GameSave.loaded.connect(on_game_save_loaded)


func on_game_save_loaded() -> void:
	init_unlocks(GameSave.lifetime_score)


func init_unlocks(score: int) -> void:
	weapons.clear()
	weapons.append(Weapon.Type.PISTOL)
	if score > 10:
		weapons.append(Weapon.Type.DUAL_PISTOLS)
	if score > 20:
		weapons.append(Weapon.Type.REVOLVER)
