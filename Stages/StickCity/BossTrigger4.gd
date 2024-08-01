extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Anim = "animation"
export (AudioStream) var musplay


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BossTrigger_area_entered(area):
	if area.is_in_group("hurtbox"):
		if Switches.foresightdefeated == 1:
			$AnimationPlayer.play(Anim)
		if musplay != null:
			Globals.music.set_stream(musplay)
			Globals.music.play()
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.
