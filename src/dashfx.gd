extends AnimatedSprite


var facedir = 1


func ready():
	play("default")
	frame = 0
	

func _process(delta):
	
	playing = true
	if flip_h == true:
		facedir = -1
	else:
		facedir = 1
	offset.x = facedir * 25
	




func _on_dashfx_animation_finished():
	queue_free()
