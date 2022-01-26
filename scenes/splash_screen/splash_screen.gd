extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Hide.show()
	
	var tween = create_tween()
	tween.tween_property($Hide, "color", Color(0, 0, 0, 0), 0.2)
	tween.tween_property($Hide, "color", Color(0, 0, 0, 1), 0.2).set_delay(1)
	tween.tween_callback(load_scene)

func load_scene():
	get_tree().change_scene("res://main.tscn")
