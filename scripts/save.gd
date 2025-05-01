extends Node2D
var config = ConfigFile.new()
@export var level = 0
func _ready():
	Global.warps = 0
	Global.double_jumps = 0
	Global.dashes = 0
	if Global.challenge == 0:
		if config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=") == OK:
			config.set_value("save", "current_level", level)
			config.set_value("save", "time", Global.time)
			config.save_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
		else:
			config.set_value("save", "current_level", level)
			config.set_value("save", "time", Global.time)
			config.save_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	elif Global.challenge == 2:
		if config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=") == OK:
			config.set_value("save", "current_level_blind", level)
			config.set_value("save", "time_blind", Global.time)
			config.save_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
		else:
			config.set_value("save", "current_level_blind", level)
			config.set_value("save", "time_blind", Global.time)
			config.save_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
			
