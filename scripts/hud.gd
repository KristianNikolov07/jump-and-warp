extends Node2D

func _process(delta):
	$warps/RichTextLabel.text = str(Global.warps)
	$double_jumps/RichTextLabel.text = str(Global.double_jumps)
	$dashes/RichTextLabel.text = str(Global.dashes)
	if Global.warps > 0:
		$warps.show()
	else:
		$warps.hide()
	if Global.double_jumps > 0:
		$double_jumps.show()
	else:
		$double_jumps.hide()
	if Global.dashes > 0:
		$dashes.show()
	else:
		$dashes.hide()
