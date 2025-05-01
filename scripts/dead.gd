extends Area2D
@export var Start_pos : Marker2D
@export var reset : Array[Area2D]
@export var MDL = false


func _on_body_entered(body):
	if Global.challenge == 1:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	else:
		body.position = get_node("../start_pos").position
		Global.double_jumps = 0
		Global.dashes = 0
		Global.warps = 0
		for node in reset:
			node.monitoring = true
			node.show()
		if MDL:
			if get_node("../Dimention2/Camera2D").enabled == true:
				get_node("../pause_menu").position.x -= get_node("../Dimention2").position.x - get_node("../Dimention1").position.x 
			get_node("../Dimention1/Camera2D").enabled = true
			get_node("../Dimention2/Camera2D").enabled = false
			
			RenderingServer.set_default_clear_color(Color.CORNFLOWER_BLUE)
			get_node("../DimentionSwitch").current = 1
			Global.warps = 0
