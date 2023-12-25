extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tform = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tform += 3
	set_region_rect(Rect2(tform, 0, 1200, 30))
#	pass
