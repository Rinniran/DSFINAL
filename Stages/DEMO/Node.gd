extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.windowmode == 1:
		$Overlay.position.x = 130
		$AnimationPlayer/Label.rect_position.x = 110
	if Globals.windowmode == 0:
		$Overlay.position.x = 130 - 32
		$AnimationPlayer/Label.rect_position.x = 110 - 32
#	pass
