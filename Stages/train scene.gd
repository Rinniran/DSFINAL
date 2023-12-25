extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		Globals.incutscene = 1
		$cameracutscene.play("Trainjump")


func _on_cameracutscene_animation_finished(anim_name):
	pass # Replace with function body.
