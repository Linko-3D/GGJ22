extends Node

func create_server():
	var peer = ENetMultiplayerPeer.new()
	print(peer)
	load_game()

func join_server():
	print("b")
	load_game()

func load_game():
	get_tree().change_scene("res://scenes/map.tscn")

func get_IP():
	print(IP.get_local_addresses())
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip
