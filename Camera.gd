extends Camera2D

func _process(delta):
	position.x = get_node("../Character").position.x
	if position.x < get_node("../end1").position.x:
		position.x = get_node("../end1").position.x
	if position.x > get_node("../end2").position.x:
		position.x = get_node("../end2").position.x

func _ready():
	RenderingServer.set_default_clear_color(Color.CORNFLOWER_BLUE)
