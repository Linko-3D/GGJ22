extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

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
