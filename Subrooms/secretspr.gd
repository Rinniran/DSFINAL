extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var this_ghost = preload("res://Stages/ghostrainbow.tscn").instance()
	get_parent().add_child(this_ghost)
	this_ghost.position = position
	this_ghost.texture = texture
	this_ghost.visible = visible
	this_ghost.scale = scale
	
	#position.x += 1
#	pass
