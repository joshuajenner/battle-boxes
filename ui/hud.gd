class_name HUD
extends MarginContainer


@export var score_label: Label

var score: int = 0


func _ready() -> void:
	score = 0
	score_label.text = str(score)


func increase_score() -> void:
	score += 1
	score_label.text = str(score)
