extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body.safe = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		body.safe = false
