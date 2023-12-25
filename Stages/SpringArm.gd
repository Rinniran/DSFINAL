extends SpringArm


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_toplevel(true)
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var Kup = Input.is_action_pressed("ui_up")
	var Kdown = Input.is_action_pressed("ui_down")
		
	if Kup:
		rotate_y(delta)
	if Kdown:
		rotate_y(-delta)
	
	rotation_degrees.y = wrapf(rotation.y, 0.0, 360.0)
	
	
	
	
	#
	
	pass
