extends AnimationPlayer




func _physics_process(delta):
	if Engine.time_scale < 1:
		playback_speed = 14
	else:
		playback_speed = 1
	
	#print_debug(playback_speed) #
	
	
	
	

