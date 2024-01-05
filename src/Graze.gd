extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 0
var OHSHIT = false
var nvm = false
var go = false

var UHOH = preload("res://Objects/UI/CLOSECALL.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if go && timer > 0:
		print_debug(timer)
		timer -= 1
	
	if timer <= 0 && go:
		OHSHIT = true
		go = false
	
	if nvm:
		go = false
		timer = 0
		nvm = false
	
	if OHSHIT:
		var goobius = UHOH.instance()
		add_child(goobius)
		OHSHIT = false
#	pass


func _on_Graze_area_entered(area):
	if area.is_in_group("undodgeable"):
		go = true
		timer = 20
	pass # Replace with function body.
