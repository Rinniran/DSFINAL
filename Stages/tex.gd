extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta):
	if Globals.lang == 0:
		$tex.mono_font = "res://Fonts/hud.tres"
	
	if Globals.lang == 1:
		$tex.mono_font = "res://Fonts/hudJ.tres"
#	pass
