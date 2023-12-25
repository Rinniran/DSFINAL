extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var kill

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Piece_area_entered(area):
	if area.is_in_group("collect"):
		Globals.pieces += 1
		Globals.score += 5
		Globals.link += 1
		Globals.linktimer = 60 * 10
		
		if Globals.pieces == 100 || Globals.pieces == 250 || Globals.pieces == 500 || Globals.pieces == 600:
			Globals.lives += 1
		
		kill = 1
	
	pass # Replace with function body.
