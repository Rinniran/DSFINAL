extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var activated = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var texture = $Viewport.get_texture()
#	$screen.texture = texture
	
	
	
	if Globals.checkpX == position.x && Globals.checkpY == position.y:
		activated = 1
	else: 
		activated = 0
		
	if activated:
		$SAVECRYSTAL.active = 1
		
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		Globals.checkpX = position.x 
		Globals.checkpY = position.y
	pass # Replace with function body.
