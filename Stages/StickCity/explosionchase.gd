extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speedmain = 240

var catchup = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if position.x > (Globals.playerpos.x + 1000):
		position.x = Globals.playerpos.x - 500
	
	if position.x < (Globals.playerpos.x - 500):
		position.x += catchup * delta
	else:
		position.x += speedmain * delta
#	pass
