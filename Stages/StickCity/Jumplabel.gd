extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.inputmode == "kb":
		text = "PRESS Z OR SPACE TO JUMP!" 
	elif Globals.inputmode == "joy":
		text = "PRESS THE A BUTTON TO JUMP!" 
#	pass
