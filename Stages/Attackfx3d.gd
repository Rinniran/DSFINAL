extends AnimatedSprite3D

var facedir = .1

func ready():
	play("default")
	frame = 0
	

func _process(delta):
	
	
	if flip_h == true:
		facedir = -.1
		get_node("hitbox").set_scale(Vector3(-1, 1, 1))
	else:
		facedir = .1
		get_node("hitbox").set_scale(Vector3(1, 1, 1))
	
	playing = true
	translation.x += facedir * 1.3
	


func _on_AnimatedSprite_animation_finished():
	queue_free()
