extends Timer


func _on_timeout():
	Global.time += 1
	print(Global.time)
