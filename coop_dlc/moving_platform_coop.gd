extends Node2D

func  _ready():
	$moving_platform.set_multiplayer_authority(1)
	if multiplayer.is_server():
		$AnimationPlayer.play("new_animation")
