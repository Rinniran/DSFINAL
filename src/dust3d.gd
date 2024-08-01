extends AnimatedSprite3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var facedir = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	play("default")
	frame = 0
	
	


func _process(delta):
	
	playing = true
	if flip_h == true:
		facedir = -1
	else:
		facedir = 1
	#offset.x = facedir * 25
	#offset.y = 25
	




func _on_dust_animation_finished():
	queue_free()
