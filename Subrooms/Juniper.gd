extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	pass





func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		
		Globals.text = 1
		Globals.cantalk = true
		
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.is_in_group("hurtbox"):
		Globals.cantalk = false
	pass # Replace with function body.
