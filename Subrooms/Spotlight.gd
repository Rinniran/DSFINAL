extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var goleft = 1
export var goright = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	if goleft:
		rotation_degrees -= 15 * _delta
		if rotation_degrees <= -28:
			goleft = 0
			goright = 1
			
	if goright:
		rotation_degrees += 15 * _delta
		if rotation_degrees >= 28:
			goright = 0
			goleft = 1
#	pass
