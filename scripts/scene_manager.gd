extends Node

const mainmenu: PackedScene = preload("res://scenes/mainmenu.tscn")
const judgement: PackedScene = preload("res://scenes/judgement.tscn")

var pref_sfx: float = 100.0
var pref_music: float = 100.0
var pref_brightness: float = 100.0

func _ready() -> void:
	if FileAccess.file_exists("user://file0.txt"):
		print("tratS")
		var dedfile = FileAccess.open("user://file0.txt", FileAccess.READ)
		if dedfile != null: print(dedfile.get_line())
		get_tree().change_scene_to_packed(judgement)
	else:
		print("Start")
		
	var conf = ConfigFile.new()
	var err = conf.load("res://preferences.cfg")
	
	if err != OK:
		conf.set_value("PREFERENCES", "SFX", 100.0)
		conf.set_value("PREFERENCES", "MUSIC", 100.0)
		conf.set_value("PREFERENCES", "MUSIC", 100.0)
		conf.save("res://preferences.cfg")
	else:
		pref_sfx = conf.get_value("PREFERENCES", "SFX")
		pref_music = conf.get_value("PREFERENCES", "MUSIC")
		pref_brightness = conf.get_value("PREFERENCES", "BRIGHTNESS")
		print(pref_sfx, pref_music, pref_brightness)

func switch_scene_to_file(scenefile: String) -> void:
	get_tree().change_scene_to_file("res://scenes/" + scenefile)

func goto_mainmenu() -> void:
	get_tree().change_scene_to_packed(mainmenu)
	
func save_settings(sfx:float, music:float, brightness:float) -> void:
	var conf = ConfigFile.new()
	conf.set_value("PREFERENCES", "SFX", sfx)
	conf.set_value("PREFERENCES", "MUSIC", music)
	conf.set_value("PREFERENCES", "BRIGHTNESS", brightness)
	conf.save("res://preferences.cfg")
	
	pref_sfx = sfx
	pref_music = music
	pref_brightness = brightness
	print(pref_sfx, pref_music, pref_brightness)
	
	var index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(index, pref_sfx)
	index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(index, pref_music)
	print("DB:",pref_sfx*0.72,pref_music*0.72)

func kill_game() -> void:
	await get_tree().create_timer(4.0).timeout
	var dedfile = FileAccess.open("user://file0.txt", FileAccess.WRITE)
	if !FileAccess.file_exists("user://recovery.dat"):
		var rec_data = FileAccess.open("user://recovery.dat", FileAccess.WRITE)
		rec_data.store_8(0)
	else:
		var rec_data = FileAccess.open("user://recovery.dat", FileAccess.WRITE)
		rec_data.store_8(1)
	OS.alert("Please try restarting the game. If the error persists, please contact the developer.", "The game has encountered an unexpected error and is going to crash.")
	OS.crash("")

func delete_game() -> void:
	DirAccess.remove_absolute("user://file0.txt")
