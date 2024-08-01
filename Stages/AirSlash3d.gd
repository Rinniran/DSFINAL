extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flip 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translation = Globals.player.translation
	#$AnimatedSprite.flip_h = flip
	rotation_degrees.z += 48
#	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()
	pass # Replace with function body.


func _on_AudioStreamPlayer_finished():
	queue_free()
	pass # Replace with function body.
