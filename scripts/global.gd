extends Node
var full_screen = true

var time = 0
var double_jumps = 0
var dashes = 0
var warps = 0

var challenge = 0
# 0 - none
# 1 - hardcore
# 2 - blind

func _input(event):
	if event.is_action_pressed("f11"):
		if full_screen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			full_screen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			full_screen = true
