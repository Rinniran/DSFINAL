extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_color = get_surface_material(0)
	#print_debug(active)
	if active:
		rotation_degrees.y += 6
		new_color.albedo_color = Color(0.254902, 0.921569, 0.101961)
		
	else:
		rotation_degrees.y += 0.3
		new_color.albedo_color = Color(0.376471, 0.905882, 0.882353)
	
	
#	pass
