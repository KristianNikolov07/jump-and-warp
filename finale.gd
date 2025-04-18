extends Node2D


func _on_ending_start_body_entered(body):
	body.moveable = false
	$AnimationPlayer.play("animation")


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://ending.tscn")
