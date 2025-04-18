extends Node2D


func _on_resume_pressed():
	hide()




func _on_back_to_menu_pressed():
	multiplayer.multiplayer_peer = null
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _input(event):
	if event.is_action_pressed("esc"):
		if visible:
			hide()
		else:
			show()
