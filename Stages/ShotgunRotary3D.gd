extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var shot = preload("res://Subrooms/Gunshot3D.tscn")

var init = 1
var inittime = 2

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
		shoti.translation = $Angle6.global_translation
		shoti.rotation_degrees.z = 40
	elif Kleft and Kdown:
		shoti.translation = $Angle4.global_translation
		shoti.rotation_degrees.z = 140
	elif Kleft:
		shoti.translation = $Angle5.global_translation
		shoti.rotation_degrees.z = 90
	elif Kright and Kup:
		shoti.translation = $Angle8.global_translation
		shoti.rotation_degrees.z = -40
	elif Kright and Kdown:
		shoti.translation = $Angle2.global_translation
		shoti.rotation_degrees.z = -140
	elif Kright:
		shoti.translation = $Angle.global_translation
		shoti.rotation_degrees.z = -90
	elif Kup:
		shoti.translation = $Angle7.global_translation
		shoti.rotation_degrees.z = -0
	elif Kdown:
		shoti.translation = $Angle3.global_translation
		shoti.rotation_degrees.z = -180
	else:
		shoti.translation = $Angle.global_translation
		shoti.rotation_degrees.z = -90
		
	
	
	if inittime > 0:
		inittime -= 1
	else:
		init = 0
	
	if Input.is_action_just_pressed("grab") && init == 0:
		get_parent().add_child(shoti)
	
	translation = Globals.player.global_translation
	
	if Globals.player.is_on_floor():
		queue_free()
#	pass
