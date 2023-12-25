extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var proj = preload("res://Subrooms/Basic Proj.tscn").instance()

var cooldown = 20

var coollimit = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	add_child(proj)
	rotation_degrees += 1
	
	#cooldown -= 1
	
	
	
#	if cooldown == coollimit:
		
#	if cooldown <= 0:
#		cooldown = coollimit
	
#	pass
