extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mframe = 0
var animtime = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frame = mframe
	animtime -= 1
	if animtime <= 0:
		mframe += 1
		animtime = 10
	if mframe > 2:
		mframe = 0
	pass
