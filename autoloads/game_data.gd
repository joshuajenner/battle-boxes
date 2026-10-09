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
	Weapon.Type.MACHINE_GUN: {
		"name": "Machine Gun",
		"path": "uid://ihwb66vklpew"
	},
	Weapon.Type.MINI_GUN: {
		"name": "Mini Gun",
		"path": "uid://ddem3lxd4gp6i"
	},
	Weapon.Type.SAW_GUN: {
		"name": "Saw Gun",
		"path": "uid://bw242arscldfl"
	},
	Weapon.Type.SHOTGUN: {
		"name": "Shotgun",
		"path": "uid://bu3twsw13j1v7"
	},
	Weapon.Type.BAZOOKA: {
		"name": "Bazooka",
		"path": "uid://dp1vp6b2vf8dr"
	},
	Weapon.Type.KNIFE: {
		"name": "Knife",
		"path": "uid://dbnorle2b8pr4"
	},
	Weapon.Type.MINES: {
		"name": "Mines",
		"path": "uid://c37ueif4a6wsg"
	},
	Weapon.Type.LAZER_GUN: {
		"name": "Lazer Gun",
		"path": "uid://dtmgw1hye6wlt"
	},
	Weapon.Type.GRENADE_LAUNCHER: {
		"name": "Grenade Launcher",
		"path": "uid://dikpng2cae4sr"
	},
	Weapon.Type.FLAMETHROWER: {
		"name": "Flamethrower",
		"path": "uid://cw5vxvopg0r52"
	},
}


var weapons: Array[Weapon.Type] = [
	Weapon.Type.PISTOL,
	Weapon.Type.DUAL_PISTOLS,
	Weapon.Type.REVOLVER,
	Weapon.Type.SHOTGUN,
	Weapon.Type.MACHINE_GUN,
	Weapon.Type.MINI_GUN,
	Weapon.Type.MINES,
	Weapon.Type.GRENADE_LAUNCHER,
	Weapon.Type.BAZOOKA,
	Weapon.Type.FLAMETHROWER,
	Weapon.Type.SAW_GUN,
	Weapon.Type.LAZER_GUN,
	Weapon.Type.KNIFE,
]
