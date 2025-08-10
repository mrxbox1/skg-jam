extends CheckBox

func _ready() -> void:
	get_parent().visible = true

func _on_pressed() -> void:
	get_parent().visible = !get_parent().visible
