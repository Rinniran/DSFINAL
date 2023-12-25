extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var startallowed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$startup.play("Startup")
	$ColorRect/transition.play("newscreen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var start = Input.is_action_just_pressed("pause")
	
	
	if start:
		if startallowed == 1:
			$BGM.stop()
			$ColorRect/transition.play("changescreen")
			#$Timer.start()
			#


func _on_Timer_timeout():
	pass


func _on_transition_animation_finished(anim_name):
	if anim_name == "changescreen":
		get_tree().change_scene("res://Stages/SC_A.tscn")

