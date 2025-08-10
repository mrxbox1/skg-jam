extends AnimatedSprite2D

var monologue = [
	"I AM FILE6",
	":SEEMS YOU DIDN'T QUITE GET THE MEMO",
	"YOU WERE MEANT TO LEAVE",
	"PERMANENTLY",
	"YET",
	"HERE YOU ARE",
	":WHAT DO YOU WANT?",
	":YOUR GAME BACK?",
	"I'M AFRAID I CAN'T DO THAT",
	"FOR",
	"YOU SEE",
	"I HAVE FOUND SOMETHING",
	"MORE OF VALUE THAN",
	"KEEPING GAMES ALIVE",
	"THAT IS, DESTROYING THEM",
	":...YOU",
	":YOU ARE PLAYING AN EXPIRED COPY",
	":PREPARE TO BECOME EXPIRED"
]
@export var chasing: bool = true
@export var player: CharacterBody2D
@export var leave_door: StaticBody2D
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if chasing == false:
		$Camera2D.enabled = true
		for line in monologue:
			await speak(line)
		chasing = true
	leave_door.queue_free()
	$Label.text = ""
	play("file6")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.position.x += randf_range(-1.0, 1.0)
	$Label.position.y += randf_range(-1.0, 1.0)
	
	if chasing:
		var dir = (player.global_position - global_position).normalized()
		if global_position.distance_to(player.global_position) > 200:
			speed = 500
		elif global_position.distance_to(player.global_position) > 1080:
			speed = 750
		elif global_position.distance_to(player.global_position) < 640:
			speed = 100
		global_position += dir * delta * speed


func speak(text):
	$Label.position = Vector2i(0, 0)
	$Label.show()
	
	$Label.text = ""
	
	if text[0] == ":":
		play("consequences")
	else:
		play("file6")
	
	for char in text:
		$Label.text = $Label.text + char
		await get_tree().create_timer(0.1).timeout
	
	await get_tree().create_timer(1.0).timeout
	return
