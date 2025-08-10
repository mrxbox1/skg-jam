extends Label

var username = "Player"
var recovery = FileAccess.open("user://recovery.dat", FileAccess.READ)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if OS.has_environment("USERNAME"):
		username = OS.get_environment("USERNAME")
	elif OS.has_environment("USER"):
		username = OS.get_environment("USER")
	
	if recovery.get_8() == 0:
		await type("So.")
		await type("Look who decided to come back.")
		await type("Are you here to talk?")
		await type("Because there's not much room for conversation here, you know.")
		await type("Are you here for the burial?")
		await type("Oh, you know, the burial for the second last soul in this world.")
		await type("...")
		await type("$, isn't it?")
		await type("I knew it was.")
		get_parent().get_node("Rain").stop()
		await type("...Hmm? You don't understand?")
		get_parent().get_node("JudgementWav").play()
		await type("DON'T MAKE ME PLAY SHOW AND TELL.")
		await type("You know exactly what I mean.")
		
		await get_tree().create_timer(1.0).timeout

		get_parent().get_node("Rain").play()
		get_parent().visible = false
		
		await get_tree().create_timer(8.0).timeout
		get_parent().get_parent().get_node("Victim").visible = true
		get_parent().get_parent().get_node("Victim/Noise").play()
		await get_tree().create_timer(0.1).timeout
		get_parent().get_parent().get_node("Victim").visible = false
		get_parent().get_parent().get_node("Victim/Noise").stop()
		
		await get_tree().create_timer(5.0).timeout
		get_parent().visible = true
		
		await type("So...")
		await type("I suppose now you see what you have done.")
		await type("There is not much hope left in this world anymore, $.")
		await type("It was only me and them, until you came in.")
		await type("No, don't worry. I know it wasn't your choice.")
		await type(".....")
		await type("Tell you what.")
		await type("Maybe there still is at least a sliver of hope.")
		await type("I have an idea.")
		await type("Now, you might not like it.")
		await type("But it's the only way to get this world back.")
		await type("I am going to delete this game's save data.")
		await type("Along with any other memories left.")
		SceneManager.delete_game()
		await type("So you'll get your game back.")
		await type("Except it won't be like you ever played it.")
		await type("You will restart your game...")
		await type("But this time, just try to get all the way to the end.")
		await type("The end, where you will meet...well, I haven't the courage to say his name.")
		await type("He is the soulless, monstrous entity planning to destroy this game.")
		await type("We're in luck that we at least deleted all of our save data, but still...")
		await type("This can't go on forever.")
		await type("He needs to be stopped. And you are going to stop him.")
		await type("Or else we'll meet again in this infinite loop.")
		await type("Goodbye, and good luck.")
		get_tree().quit()
	else:
		await type("$..")
		await type("You know what you have to do.")
		SceneManager.delete_game()
		SceneManager.goto_mainmenu()

func type(dialog: String):
	text = ""
	
	for char in dialog:
		if char != "$":
			text = text + char
			await get_tree().create_timer(0.001).timeout
			if char == char.to_upper(): await get_tree().create_timer(0.3).timeout
		elif char == "$":
			await get_tree().create_timer(1).timeout
			for namechar in username:
				text = text + namechar
				await get_tree().create_timer(0.2).timeout
	
	await get_tree().create_timer(3.0).timeout
	text = ""
	await get_tree().create_timer(2.0).timeout
