extends Node
@export var current = 1

func _input(event):
	if event.is_action_pressed("warp") and Global.warps > 0:
		if current == 1:
			get_node("../Character").position.x += get_node("../Dimention2").position.x - get_node("../Dimention1").position.x 
			get_node("../pause_menu").position.x += get_node("../Dimention2").position.x - get_node("../Dimention1").position.x 
			get_node("../Dimention1/Camera2D").enabled = false
			get_node("../Dimention2/Camera2D").enabled = true
			RenderingServer.set_default_clear_color(Color.DODGER_BLUE)
			current = 2
		else:
			get_node("../Character").position.x -= get_node("../Dimention2").position.x - get_node("../Dimention1").position.x 
			get_node("../pause_menu").position.x -= get_node("../Dimention2").position.x - get_node("../Dimention1").position.x 
			get_node("../Dimention1/Camera2D").enabled = true
			get_node("../Dimention2/Camera2D").enabled = false
			RenderingServer.set_default_clear_color(Color.CORNFLOWER_BLUE)
			current = 1
		Global.warps -= 1
