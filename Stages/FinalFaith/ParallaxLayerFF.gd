extends ParallaxLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = 20
	position.y = -35.291
	scale.x = 0.5
	scale.y = 0.5
	motion_mirroring.x = -1 #960.49

