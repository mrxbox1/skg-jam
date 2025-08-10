extends Button

@export var scene: String = "levels/tutorial.tscn"


func _on_pressed() -> void:
	SceneManager.switch_scene_to_file(scene)
