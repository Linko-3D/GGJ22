extends Node

func create_server():
	var peer = ENetMultiplayerPeer.new()
	print(peer)

func join_server():
	print("b")

func get_IP():
	print(IP.get_local_addresses())
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip
