extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Credit.modulate = Color(1, 1, 1, 0)
	$Menu.modulate =  Color(1, 1, 1, 0)

	var tween = create_tween()
	tween.tween_property($Menu, "modulate", Color(1, 1, 1, 1), 0.5)
	tween.tween_property($Credit, "modulate", Color(1, 1, 1, 1), 0.5).set_delay(0.5)
	tween.set_parallel().tween_property($Credit, "rect_position:x", 20.0, 0.5).set_delay(0.5)

	$Menu/LocalIP.text = "My local IP: " + Network.get_IP()

func _on_quit_pressed():
	get_tree().quit()

func _on_host_pressed():
	Network.create_server()

func _on_join_pressed():
	Network.join_server()
