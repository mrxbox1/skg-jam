extends AnimatedSprite2D

@export var enabled: bool = false
@export var targeting_collider: StaticBody2D
var touched = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled: frame = 1
	else: frame = 0

func _process(delta: float) -> void:
	if touched and Input.is_action_just_pressed("interact"):
		enabled = !enabled
		for child in targeting_collider.get_children():
			child.disabled = !child.disabled
	if enabled: frame = 1
	else: frame = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		touched = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		touched = false
