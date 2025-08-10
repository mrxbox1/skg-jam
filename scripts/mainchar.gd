# i hate my life
# fuck around with the code if you want, it's all duct taped

extends CharacterBody2D

enum states {IDLE, MOVE, ANNOY, FALLDIE, BURNDIE, DROWNDIE}

const SPEED = 200.0
const JUMP_VELOCITY = -200.0
const RANDIMATIONS: PackedStringArray = ["annoyed1", "annoyed2", "annoyed3", "annoyed4", "annoyed5", "annoyed6", "annoyed7", "annoyed8"]

@export var state: states = states.IDLE
@export var next_level: String
@export var music: AudioStreamPlayer
@onready var animator = $AnimatedSprite2D
var death = load("res://scenes/jumpscare.tscn")
var laststep: float = 0.0
var falling: bool = false
var safe: bool = false
var cheats: bool = false
var underwater: float = 0.0

func _physics_process(delta: float) -> void:
	if state not in [states.ANNOY, states.FALLDIE, states.BURNDIE, states.DROWNDIE]:
		if not is_on_floor():
			if falling == false: 
				laststep = global_position.y
				falling = true
			velocity += get_gravity() * delta
		else:
			falling = false
			if ((global_position.y - laststep) > 100.0) and safe == false:
				state = states.FALLDIE
			else:
				laststep = global_position.y
		
		if Input.is_action_just_pressed("jump") and (state in [states.IDLE, states.MOVE]):
			if (is_on_floor() and cheats == false) or (cheats == true):
				velocity.y = JUMP_VELOCITY
				$Jump.play()
		
		if state in [states.IDLE, states.MOVE]:
			var direction := Input.get_axis("left", "right")
			if direction:
				velocity.x = direction * SPEED
				state = states.MOVE
				animator.play("walk")
				if Input.is_action_pressed("left"):
					animator.flip_h = true
				elif Input.is_action_pressed("right"):
					animator.flip_h = false
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				state = states.IDLE
				animator.play("idle")
		
		move_and_slide()
	elif state == states.ANNOY:
		await animator.animation_finished
		state = states.IDLE
	elif state in [states.FALLDIE, states.BURNDIE, states.DROWNDIE]:
		if !$Death.playing: $Death.play()
		if state == states.FALLDIE: 
			if animator.animation != "falldeath": 
				animator.play("falldeath")
		if state in [states.BURNDIE, states.DROWNDIE]: 
			if animator.animation != "burndeath": 
				animator.play("burndeath")
		SceneManager.kill_game()
	
	if OS.is_debug_build():
		$Camera2D/Label.text = str(state)
		if cheats == true: $Camera2D/Label.text += "\ncheats activated"
		$Camera2D/Label.text += "\n" + str(laststep)
		$Camera2D/Label.text += "\n" + str(safe)
	
	if Input.is_action_just_pressed("ui_home"):
		cheats = !cheats
	
	if $Nostrils/CPUParticles2D.emitting:
		underwater += 1.0 * delta
	if underwater >= 20.0: 
		state = states.DROWNDIE

func _on_button_pressed() -> void:
	if (state not in [states.ANNOY, states.FALLDIE, states.BURNDIE, states.DROWNDIE]) and is_on_floor():
		animator.play(RANDIMATIONS[randi_range(0,len(RANDIMATIONS)-1)])
		state = states.ANNOY


func _on_safety_area_area_entered(area: Area2D) -> void:
	if area.name == "Win":
		SceneManager.switch_scene_to_file(next_level)
	if area.name.begins_with("Lava"):
		state = states.BURNDIE
	if area.name.begins_with("Spike"):
		state = states.FALLDIE

func _on_nostrils_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Water"):
		$Nostrils/CPUParticles2D.emitting = true

func _on_nostrils_area_exited(area: Area2D) -> void:
	if area.name.begins_with("Water"):
		$Nostrils/CPUParticles2D.emitting = false
