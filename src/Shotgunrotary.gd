extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var shot = preload("res://Subrooms/Gunshot.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var shoti = shot.instance()
	
	var Kleft = Input.is_action_pressed("ui_left") or Input.get_action_strength("stickleft")
	var Kright = Input.is_action_pressed("ui_right") or Input.get_action_strength("stickright")
	var Kup = Input.is_action_pressed("ui_up") or Input.get_action_strength("stickup")
	var Kdown = Input.is_action_pressed("ui_down") or Input.get_action_strength("stickdown")
	
	
	if (Kleft and Kup):
		shoti.position = $Angle6.global_position
		shoti.rotation_degrees = -40
	elif Kleft and Kdown:
		shoti.position = $Angle4.global_position
		shoti.rotation_degrees = -140
	elif Kleft:
		shoti.position = $Angle5.global_position
		shoti.rotation_degrees = -90
	elif Kright and Kup:
		shoti.position = $Angle8.global_position
		shoti.rotation_degrees = 40
	elif Kright and Kdown:
		shoti.position = $Angle2.global_position
		shoti.rotation_degrees = 140
	elif Kright:
		shoti.position = $Angle.global_position
		shoti.rotation_degrees = 90
	elif Kup:
		shoti.position = $Angle7.global_position
		shoti.rotation_degrees = 0
	elif Kdown:
		shoti.position = $Angle3.global_position
		shoti.rotation_degrees = 180
	else:
		shoti.position = $Angle.global_position
		shoti.rotation_degrees = 90
		
	
	
	if Input.is_action_just_pressed("grab"):
		get_parent().add_child(shoti)
	
	position = Globals.playerpos
	if is_instance_valid(Globals.player):
		if Globals.player.is_on_floor():
			queue_free()
#	pass
