extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scroll = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scroll == 0:
		scale.x -= 0.8 * delta
	if scroll == 1:
		scale.x += 0.8 * delta
		
	if scale.x >= .5:
		scroll = 0
	if scale.x <= -.5:
		scroll = 1
#	pass
