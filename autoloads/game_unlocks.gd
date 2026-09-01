class_name GameUnlocks
extends Node


var weapons: Dictionary = {
	"pistol": {
		"name": "Pistol",
		"path": "res://weapons/pistol/pistol.tscn"
	},
	"dual_pistols": {
		"name": "Pistols Akimbo",
		"path": "res://weapons/dual_pistols/dual_pistols.tscn"
	},
	"revolver": {
		"name": "Revolver",
		"path": "res://weapons/revolver/revolver.tscn"
	},
}




func run_unlocks(score: int) -> void:
	if score > 10:
		pass
