extends CanvasLayer


@export var score_label: Label


var score: int = 0


func _ready() -> void:
	GameEvent.crate_picked_up.connect(on_crate_picked_up)
	
	score = 0
	score_label.text = str(score)


func on_crate_picked_up() -> void:
	score += 1
	score_label.text = str(score)
