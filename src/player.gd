extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var SPEED
var ACC
var JFORCE
var HP
var LIVES
var CARDS

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	
	
	
	
	
	
	
	
	
	if Input.is_action_pressed("ui_right"):
		get_node( "Rspr" ).set_flip_h( false )
	elif Input.is_action_pressed("ui_left"):
		get_node( "Rspr" ).set_flip_h( true )
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
