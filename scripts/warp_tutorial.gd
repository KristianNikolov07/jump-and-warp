extends Node2D

func _process(delta):
	if Global.warps > 0:
		$pick_up.hide()
		$warp.show()
