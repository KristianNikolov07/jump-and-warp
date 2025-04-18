extends Node2D
var peer
func _ready():
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connection_failed.connect(connection_failed)

@rpc("any_peer", "call_local")
func start_game(guide_id):
	Global.guide_id = guide_id
	get_tree().change_scene_to_file("res://coop_dlc/coop_scene.tscn")



func peer_connected(id):
	$Host_settings/start.disabled = false
	$Host_settings/start.text = "Start Game"

func peer_disconnected(id):
	$Host_settings/start.disabled = true
	$Host_settings/start.text = "Waiting for a player"
	$Waiting.enabled = false
func connection_failed():
	print("connection_failed")
	
func connected_to_server():
	print("connected")
	$LAN.enabled = false
	$Waiting.enabled = true
	
func _on_host_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(3000, 2)
	multiplayer.multiplayer_peer = peer
	$LAN.enabled = false
	$Host_settings.enabled = true
	$Host_settings/address.text = "Your address is: " + str(IP.get_local_addresses()[2])

func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client($LAN/Join_address.text, 3000)
	multiplayer.multiplayer_peer = peer


func _on_start_pressed():
	if $Host_settings/guide.selected == 0:
		start_game.rpc(1)
	else:
		start_game.rpc(multiplayer.get_peers()[0])
	


func _on_back_pressed():
	$LAN.enabled = false


func _on_back_to_menu_pressed():
	multiplayer.multiplayer_peer = null
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_play_on_lan_pressed():
	$LAN.enabled = true
