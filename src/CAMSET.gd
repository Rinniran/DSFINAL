extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var CAMLEFT = 0

export var CAMBOTTOM = 0

export var CAMRIGHT = 0

export var CAMTOP = 0

export (AudioStream) var musplay

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Camsetter_area_entered(area):
	if area.is_in_group("hurtbox"):
		Globals.camera.limit_left = CAMLEFT
		Globals.camera.limit_right = CAMRIGHT
		Globals.camera.limit_top = CAMTOP
		Globals.camera.limit_bottom = CAMBOTTOM
		if musplay != null:
			Globals.music.set_stream(musplay)
			Globals.music.play()
		Globals.yokaiball = 1
		queue_free()
	pass # Replace with function body.
