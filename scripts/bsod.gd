extends ColorRect

@export var boot_node: Control
@export var desktop: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$Label.hide()
	boot_node.hide()
	desktop.hide()
	await get_tree().create_timer(1.0).timeout
	show()
	await get_tree().create_timer(0.75).timeout
	$Label.show()
	await get_tree().create_timer(5.0).timeout
	hide()
	await get_tree().create_timer(1.0).timeout
	boot_node.show()
	
	for i in randi_range(80, 100):
		boot_node.get_node("ProgressBar").value += randf_range(-0.1, 3.0)
		await get_tree().create_timer(0.1).timeout
	
	boot_node.hide()
	desktop.show()
