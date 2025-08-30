extends Button

@export var sfx: HSlider
@export var music: HSlider
@export var brightness: HSlider

func _on_pressed() -> void:
	SceneManager.save_settings(sfx.value, music.value, brightness.value)
	SceneManager.goto_mainmenu()
