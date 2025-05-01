extends Node2D
var paused = false
var config = ConfigFile.new()
var walkthrough = {
	"0" : "0",
	"1" : "6",
	"2" : "11",
	"3" : "18",
	"4" : "22",
	"5" : "28",
	"6" : "37",
	"7" : "50",
	"8" : "54",
	"9" : "60",
	"10" : "75",
	"11" : "79",
	"12" : "84",
	"13" : "109",
	"14" : "113",
	"15" : "125"
}

func _input(event):
	if event.is_action_pressed("esc"):
		if paused == false:
			show()
			paused = true
			get_tree().paused = true
		else:
			hide()
			paused = false
			get_tree().paused = false
	


func _on_resume_pressed():
	hide()
	paused = false
	get_tree().paused = false


func _on_back_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_walktrough_pressed():
	config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	var level = config.get_value("save", "current_level")
	OS.shell_open("https://www.youtube.com/watch?v=5bN2CxGJuYU&t=" + walkthrough.get(str(level)))
