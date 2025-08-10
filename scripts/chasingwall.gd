extends Sprite2D

@export var speed = 201

func _process(delta: float) -> void:
	global_position.x += speed * delta
