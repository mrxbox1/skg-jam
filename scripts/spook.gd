extends AnimatedSprite2D

@export var spook_duration: float = 1.0
@export var spook_text: String = "STOP"

func _ready() -> void:
	hide()
	$Label.text = spook_text

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		play()
		show()
		$Noise.play()
		$Label.position.x += randf_range(-2.0, 2.0)
		$Label.position.y += randf_range(-2.0, 2.0)
		await get_tree().create_timer(spook_duration).timeout
		$Noise.stop()
		hide()
		queue_free()
