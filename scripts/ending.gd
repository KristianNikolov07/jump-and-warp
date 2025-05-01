extends Node2D

func _ready():
	var config = ConfigFile.new()
	if config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=") == OK:
		if Global.challenge == 0:
			config.set_value("save", "current_level", 0)
			config.set_value("save", "time", null)
		elif Global.challenge == 2:
			config.set_value("save", "current_level_blind", 0)
			config.set_value("save", "time_blind", null)
		config.set_value("save", "challenges_unlocked", true)
		config.save_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	
	$completion_time_text.text = "[center]"
	var secs = Global.time
	var mins = 0
	var hours = 0
	if secs > 59:
		mins = secs / 60
		secs = secs % 60
		if mins > 59:
			hours = mins / 60
			mins = mins % 60
	
	if hours < 10:
		$completion_time_text.text += "0" + str(hours) + " : "
	else:
		$completion_time_text.text += str(hours) + " : "
	
	if mins < 10:
		$completion_time_text.text += "0" + str(mins) + " : "
	else:
		$completion_time_text.text += str(mins) + " : "
		
	if secs < 10:
		$completion_time_text.text += "0" + str(secs)
	else:
		$completion_time_text.text += str(secs)
	
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_upload_pressed():
	$upload.text = "Uploading..."
	$upload.disabled = true
	$name.editable = false
	$Button.disabled = true
	if Global.challenge == 0:
		$GameJoltAPI.scores_add(str(Global.time) + " Seconds", Global.time, $name.text, 908686)
	elif Global.challenge == 1:
		$GameJoltAPI.scores_add(str(Global.time) + " Seconds", Global.time, $name.text, 908687)
	elif Global.challenge == 2:
		$GameJoltAPI.scores_add(str(Global.time) + " Seconds", Global.time, $name.text, 908688)

func _on_name_text_changed(new_text):
	if $name.text == "":
		$upload.disabled = true
	else:
		$upload.disabled = false


func _on_toni_easter_egg_button_pressed():
	get_tree().change_scene_to_file("res://scenes/toni_easter_egg.tscn")


func _on_game_jolt_api_gamejolt_request_completed(type: String, message: Dictionary) -> void:
	if OS.get_name() == "Web":
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	else:
		if message['success'] == false:
			$upload.text = "Try again"
			$upload.disabled = false
			$name.editable = true
			$Button.disabled = false
			$error.show()
		else:
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
