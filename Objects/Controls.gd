extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shutup = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = Globals.controlsoverlay
	
	if Input.is_action_just_pressed("ctrl") && shutup == false:
		Globals.controlsoverlay = !Globals.controlsoverlay
	
	
	
	
	match (Globals.inputmode):
		"kb":
			$inputprompt5/Label2.text = "CTRL"
			$inputprompt4/Label2.text = "Z"
			$inputprompt/Label2.text = "C"
			$inputprompt2/Label2.text = "SHIFT"
		"joy":
			$inputprompt5/Label2.text = "RB"
			$inputprompt/Label2.text = "Y"
			$inputprompt2/Label2.text = "B"
			$inputprompt4/Label2.text = "A"
#	pass
