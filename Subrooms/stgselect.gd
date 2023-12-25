extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var STGid = 0

var selected = "res://Stages/SC_A.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("ui_right"):
		STGid += 1
		
		
	if Input.is_action_just_pressed("ui_left"):
		STGid -= 1
		
		
		
		
	if STGid > 6:
		STGid = 6
		
	if STGid < 0:
		STGid = 0
	
	match(STGid):
		0:
			text = "Stick City\n\nA"
			selected = "res://Stages/SC_A.tscn"
		1:
			text = "Stick City\n\nB"
			selected = "res://Stages/SC_B.tscn"
		2:
			text = "Stick City\n\nC"
			selected = "res://Stages/SC_C.tscn"
		3:
			text = "Truth Garden\n\nA"
			selected = "res://Stages/Truth Garden/TG_A.tscn"
		4:
			text = "Final Faith\n\nB"
			selected = "res://Stages/FinalFaith/FF_B.tscn"
		5:
			text = "Staff Roll"
			selected = "res://Stages/StaffRoll/StaffRoll.tscn"
		6:
			text = "Tutorial"
			selected = "res://Stages/tut.tscn"
			
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene(selected)
