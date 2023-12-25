extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var manualrot = false
export var autorot = true
export var right = true
export var left = false


export var speed = 20

var acc = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if autorot:
		if left:
			rotate_y(-delta)
		if right:
			rotate_y(delta)
	
	if manualrot:
		var Kleft = Input.is_action_pressed("ui_left")
		var Kright = Input.is_action_pressed("ui_right")
		if Kright:
			rotation_degrees.y += acc
		elif Kleft:
			rotation_degrees.y -= acc
		
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
