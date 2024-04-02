extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = "wawa"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Damage.text = value
	$Damage/AnimationPlayer.playback_active = true
	$Damage/AnimationPlayer.play("Spawn")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Damage.rect_position.y -= 1
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.
