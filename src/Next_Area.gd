extends Node
export var next = "Insert Stage Dir"
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
		$".".queue_free()
		Sys.load_scene(self,"res://Stages/StickCity/A-2.tscn")
	pass # Replace with function body.
