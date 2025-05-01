extends Area2D
var player_in = false


func _on_body_entered(body):
	player_in = true

func _on_body_exited(body):
	player_in = false
	
func _input(event):
	if event.is_action_pressed("interact") and player_in:
		Global.dashes += 1
		hide()
		monitoring = false
