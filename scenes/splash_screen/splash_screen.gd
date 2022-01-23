extends Control

func _ready():
	$Hide.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	var tween = create_tween()
	tween.tween_property($Hide, "color", Color(0, 0, 0, 0), 0.5).set_delay(0.5)
	tween.tween_property($Hide, "color", Color(0, 0, 0, 1), 0.5).set_delay(2)
	tween.tween_callback(load_scene)

func load_scene():
	get_tree().change_scene("res://main.tscn")
