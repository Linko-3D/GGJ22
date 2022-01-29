extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Hide.show()
	$Credit.modulate = Color(1, 1, 1, 0)
	$Menu.modulate = Color(1, 1, 1, 0)
	$Credit.percent_visible = 0

	var tween = create_tween()
	tween.tween_property($Hide, "color", Color(0, 0, 0, 0), 0.2)
	tween.tween_property($Menu, "modulate", Color(1, 1, 1, 1), 0.2)
	tween.tween_callback($Hide.hide)
	tween.tween_property($Credit, "offset_left", 20.0, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.set_parallel().tween_property($Credit, "modulate", Color(1, 1, 1, 1), 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.set_parallel().tween_property($Credit, "percent_visible", 1.0, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_host_pressed():
	Network.create_server()

func _on_join_pressed():
	if $Menu/ToLocalIP.text == "":
		Network.join_server($Menu/ToLocalIP.placeholder_text)
	else:
		Network.join_server($Menu/ToLocalIP.text)

func _on_quit_pressed():
	get_tree().quit()

func _on_to_local_ip_text_submitted(new_text):
	_on_join_pressed()
