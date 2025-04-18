extends Node2D
@export var platform : PackedScene
@export var moving_platform : PackedScene
@export var Dead : PackedScene
@export var Booster : PackedScene
@export var Double_jump : PackedScene
@export var End : PackedScene
@export var Ending : PackedScene
func _ready():
	Global.time = 0
	multiplayer.peer_disconnected.connect(peer_disconnected)
	if multiplayer.is_server():
		generate()
	if int(multiplayer.get_unique_id()) != Global.guide_id:
		$Character.set_multiplayer_authority(multiplayer.get_unique_id())
		$objects.hide()
	else:
		$Character.set_multiplayer_authority(multiplayer.get_peers()[0])
		$Character.moveable = false
		RenderingServer.set_default_clear_color(Color.DODGER_BLUE)

func peer_disconnected(id):
	print("disconnected")
	get_tree().change_scene_to_file("res://coop_dlc/coop_menu.tscn")


func generate():
	var pos = $Start_pos.position
	for i in range(30):
		var j = randi_range(1, 10)
		if j < 10:
			var platform_scale = randi_range(2, 3)
			var platform_pos : Vector2
			platform_pos.x = pos.x + randi_range(1, 4) * 64
			platform_pos.y = pos.y + randi_range(-1, 3) * 64
			while platform_pos.y > 700 or platform_pos.y < 0:
				platform_pos.y = pos.y + randi_range(-1, 3) * 64
			pos.x = platform_pos.x + platform_scale * 64
			pos.y = platform_pos.y
			set_platform.rpc(platform_pos, platform_scale)
		else:
			var booster_pos : Vector2
			booster_pos.x = pos.x + randi_range(1, 4) * 64
			booster_pos.y = pos.y + randi_range(-1, 3) * 64
			while booster_pos.y > 700 or booster_pos.y < 0:
				booster_pos.y = pos.y + randi_range(-1, 3) * 64
			pos.x = booster_pos.x + 8 * 64
			pos.y = booster_pos.y
			set_booster.rpc(booster_pos)
	set_end.rpc(pos)
	
	

@rpc("any_peer", "call_local")
func set_platform(pos, platform_scale):
	var platfrom_node = platform.instantiate()
	platfrom_node.position = pos
	platfrom_node.scale.x = platform_scale
	$objects.add_child(platfrom_node)
	
@rpc("any_peer", "call_local")
func set_booster(pos):
	var booster_node = Booster.instantiate()
	var platfrom_node = platform.instantiate() 
	platfrom_node.position = pos
	platfrom_node.position.x += 6 * 64
	platfrom_node.scale.x = 2
	booster_node.position = pos
	$objects.add_child(platfrom_node)
	$objects.add_child(booster_node)

@rpc("any_peer", "call_local")
func set_end(pos):
	var end_node = End.instantiate()
	end_node.position = pos
	end_node.position.x += 20
	end_node.level = Ending
	$objects.add_child(end_node)
	$Character/Camera2D.limit_right = pos.x
