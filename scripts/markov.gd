extends Label

var corpus = "use a HAYSTACK , it'll break your fall . use a LEVER , it'll open a door . use a LADDER , it will elevate you . a lost game is a lost game . use your AGILITY , it will help you . the NARRATOR is an all knowing entity that will guide you , or at least not yet . you must not trust HIM . who am i ? that is up to you to find out . avoid LAVA , it will burn you . avoid WATER , it will drown you . avoid SPIKES , they will prick you . move with arrow keys . jump with SPACE , or use UP , if you prefer . interact with Z , or use ENTER , if you prefer . prepare for the climb , for it is very steep . see the future in your dreams , until you wake up . remember to breathe , anger will not help . remember to wait , patience is key . your preferences matter , which is why you are here . tweak SFX to your liking . tweak MUSIC to your liking . mute one , or both if you shall . the END is soon ."

func build_model(source):
	source = source.split(" ")
	var model = {}
	var next_word: String
	
	for i in range(len(source)):
		#print(source[i])
		model[source[i]] = []

	for i in range(len(source)):
		if source[i] != source[-1]:
			next_word = source[i + 1]
		else:
			next_word = "..."
		#print("Next word:", next_word)
		model[source[i]].append(next_word)

	model["..."] = ["..."]

	return model

func generate_text(model, length):
	var final_result = []

	var starting_word = model.keys()[randi() % model.keys().size()]
	#print("STARTING WORD:", starting_word)
	
	var next_word = model[starting_word][randi() % model[starting_word].size()]
	#print("NEXT WORD:", next_word)
	final_result.append(starting_word)
	final_result.append(next_word)
	
	for i in range(length):
		next_word = model[next_word][randi() % model[next_word].size()]
		#print("NEXT WORD:", next_word)
		if next_word == "...": break
		final_result.append(next_word)

	return final_result

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var final_model = build_model(corpus)
	text = " ".join(generate_text(final_model, randi_range(5,50)))
