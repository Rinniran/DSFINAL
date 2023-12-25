extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var next = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Main")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if Input.is_action_just_pressed("pause") || Input.is_action_just_pressed("jump"):
#		Sys.load_scene(self,next)
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	Sys.load_scene(self,next)
	pass # Replace with function body.
