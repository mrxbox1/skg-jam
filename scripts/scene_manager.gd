extends Node

const mainmenu: PackedScene = preload("res://scenes/mainmenu.tscn")
const judgement: PackedScene = preload("res://scenes/judgement.tscn")

func _ready() -> void:
	if FileAccess.file_exists("user://file0.txt"):
		print("tratS")
		var dedfile = FileAccess.open("user://file0.txt", FileAccess.READ)
		if dedfile != null: print(dedfile.get_line())
		get_tree().change_scene_to_packed(judgement)
	else:
		print("Start")
	

func switch_scene_to_file(scenefile: String) -> void:
	get_tree().change_scene_to_file("res://scenes/" + scenefile)

func goto_mainmenu() -> void:
	get_tree().change_scene_to_packed(mainmenu)

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
