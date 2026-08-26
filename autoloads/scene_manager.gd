extends CanvasLayer


@onready var overlay: ColorRect = $Overlay
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	#test_scene_paths()
	layer = RenderingServer.CANVAS_LAYER_MIN
	overlay.color.a = 0


#func test_scene_paths() -> void:
	#for scene in Scenes.ALL_SCENES:
		#if not ResourceLoader.exists(scene):
			#push_error("Scene defined in Scenes does not exist. -> " + scene)


func fade_in_overlay() -> void:
	layer = RenderingServer.CANVAS_LAYER_MAX
	animation_player.play("fade_in")


func fade_out_overlay() -> void:
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	layer = RenderingServer.CANVAS_LAYER_MIN


func switch_to(scene_path: String) -> void:
	fade_in_overlay()
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	get_tree().paused = false
	fade_out_overlay()


func reload_current_scene() -> void:
	fade_in_overlay()
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	get_tree().paused = false
	fade_out_overlay()
