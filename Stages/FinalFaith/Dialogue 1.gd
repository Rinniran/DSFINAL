extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var D = preload("res://Audio/Voices/Dialogue/Final Faith/Dialogue 1.wav")
export var S = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Dialogue_1_area_entered(area):
	if area.is_in_group("hurtbox"):
		$PlayDialogue.play(S)
		$collision.queue_free()
