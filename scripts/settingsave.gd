extends Button

@export var sfx: HSlider
@export var music: HSlider
@export var brightness: HSlider

func _ready() -> void:
	sfx.value = SceneManager.pref_sfx
	music.value = SceneManager.pref_music

func _process(delta: float) -> void:
	SceneManager.save_settings(sfx.value, music.value)

func _on_pressed() -> void:
	SceneManager.save_settings(sfx.value, music.value)
	SceneManager.goto_mainmenu()
