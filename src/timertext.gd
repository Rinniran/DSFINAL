extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var font

# Called when the node enters the scene tree for the first time.
func _update(delta):
	$timer.set_font("res://Fonts/hud.tres")

	
	visible = $GUI.visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func add_text(next_text):
	$timer.text = "dada"
