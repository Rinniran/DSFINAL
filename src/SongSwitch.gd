extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (AudioStream) var musplay

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SongSwitch_area_entered(area):
	if area.is_in_group("hurtbox"):
		if Globals.music.stream != musplay:
			Globals.music.set_stream(musplay)
			Globals.music.play()
