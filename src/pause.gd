extends Control


func _input(event):
	var pause = Input.is_action_just_pressed("pause")
	if pause:
		var pstate = not get_tree().paused
		get_tree().paused = pstate
		visible = pstate
	
	
	
	
	
	
