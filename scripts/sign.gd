extends Area2D

@export var sign_text: PackedStringArray = ["Hello, World!", "This is a sign!"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/MarginContainer/RichTextLabel.text = sign_text[0]
	sign_text.remove_at(0)
	for line in sign_text:
		$PanelContainer/MarginContainer/RichTextLabel.add_text("\n" + line)
	$PanelContainer.visible = false



func _on_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D": $PanelContainer.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D": $PanelContainer.visible = false
