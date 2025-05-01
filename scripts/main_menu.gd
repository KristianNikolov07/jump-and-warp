extends Control

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

func _ready():
	if config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=") == OK:
		if config.has_section_key("save", "current_level") and config.get_value("save", "current_level") > 0:
			$continue.disabled = false
		if config.has_section_key("save", "current_level_blind") and config.get_value("save", "current_level_blind") > 0:
			$challenges_cam/continue_blind.disabled = false
		if config.get_value("save", "challenges_unlocked") == true:
			$challenges.show()
		if OS.get_name() == "Web":
			$Quit.hide()


func _on_quit_pressed():
	get_tree().quit()



func _on_credits_pressed():
	$credits_cam.enabled = true


func _on_back_to_menu_pressed():
	$credits_cam.enabled = false
	$challenges_cam.enabled = false

func _on_new_game_pressed():
	config.set_value("save", "current_level", 0)
	config.save_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	Global.challenge = 0
	Global.time = 0
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")


func _on_continue_pressed():
	config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	var level = config.get_value("save", "current_level")
	Global.time = config.get_value("save", "time")
	Global.challenge = 0
	get_tree().change_scene_to_file("res://scenes/level_" + str(level) + ".tscn")


func _on_challenges_pressed():
	$challenges_cam.enabled = true


func _on_hardcore_start_pressed():
	Global.challenge = 1
	Global.time = 0
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")


func _on_new_game_blind_pressed():
	config.set_value("save", "current_level_blind", 0)
	config.save_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	Global.challenge = 2
	Global.time = 0
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")


func _on_continue_blind_pressed():
	config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	var level = config.get_value("save", "current_level_blind")
	Global.time = config.get_value("save", "time_blind")
	Global.challenge = 2
	get_tree().change_scene_to_file("res://scenes/level_" + str(level) + ".tscn")


func _on_leaderboard_pressed():
	OS.shell_open("https://gamejolt.com/games/jump-and-swap/897305/scores/908686/best")


func _on_walktrough_pressed():
	config.load_encrypted_pass("user://save.txt", "bWFqa2EgemFqa2E=")
	var level = config.get_value("save", "current_level")
	OS.shell_open("https://www.youtube.com/watch?v=5bN2CxGJuYU&t=" + walkthrough.get(str(level)))
