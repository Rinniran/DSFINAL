extends AnimatedSprite

var facedir = 1

func ready():
	play("default")
	frame = 0
	

func _process(delta):
	
	
	if flip_h == true:
		facedir = -1
		get_node("hitbox").set_scale(Vector2(-1, 1))
	else:
		facedir = 1
		get_node("hitbox").set_scale(Vector2(1, 1))
	
	playing = true
	position.x += facedir * 10
	


func _on_AnimatedSprite_animation_finished():
	queue_free()
