extends Node2D

func _ready():
	if Global.challenge == 2:
		for child in get_node("../").get_children():
			if child.name != "Character":
				if child.has_method("hide"):
					child.hide()
