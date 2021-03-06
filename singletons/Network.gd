extends Node

var map = "res://scenes/map.tscn"
var main = "res://main.tscn"
var player = preload("res://player/Player.tscn")
var spawn_node = null

var peer = ENetMultiplayerPeer.new()

func _ready():
	peer.peer_connected.connect(_peer_connected)
	peer.peer_disconnected.connect(_peer_disconnected)
	peer.connection_succeeded.connect(_connection_succeeded)
	peer.server_disconnected.connect(_server_disconnected)

func get_IP():
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip

func create_server():
	peer.create_server(4242)
	multiplayer.set_multiplayer_peer(peer)

	load_game()

func join_server(ip):
	peer.create_client(ip, 4242)
	multiplayer.set_multiplayer_peer(peer)

func _connection_succeeded():
	load_game()

func load_game():
	get_tree().change_scene(map)
	
	await get_tree().create_timer(0.01).timeout
	
	spawn_node = get_tree().get_root().find_node("Spawn", true, false)
	
	if not multiplayer.is_server():
		spawn_player(multiplayer.get_unique_id())
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		var message = Label.new()
		message.text = "    Server local IP:    " + get_IP()
		message.modulate = Color(1, 1, 1, 0)
		add_child(message)
		
		var tween = create_tween().set_loops(3)
		tween.tween_property(message, "modulate", Color(1, 1, 1, 0), 0.15)
		tween.tween_property(message, "modulate", Color(1, 1, 1, 1), 0.15)

func spawn_player(id):
	var player_instance = player.instantiate()
	player_instance.name = str(id)

	player_instance.set_multiplayer_authority(id)

	if spawn_node:
		spawn_node.add_child(player_instance)
	else:
		get_tree().get_root().add_child(player_instance)

func _peer_connected(id):
	if id != 1:
		spawn_player(id)

func _peer_disconnected(id):
	if id != 1:
		get_tree().get_root().find_node(str(id), true, false).queue_free()

func _server_disconnected():
	get_tree().change_scene(main)
	multiplayer.set_multiplayer_peer(null)
