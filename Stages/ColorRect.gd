extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shader_value = material.get_shader_param("Right")
var done = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var start = Input.is_action_just_pressed("pause")
	
#	pass
