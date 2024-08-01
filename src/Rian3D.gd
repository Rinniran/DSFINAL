extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var WALKSPEED = 250

var DASHSPEED = 200

var JFORCE = 800

var WAVESPEED = 800

var UP = Vector3.UP

var SNAPLEN = 400.0

var SNAPDIR = Vector3.DOWN

var SNAPVEC = Vector3(0,-1,0)

var VELOCITY = Vector3()

var GRAVITY: = 4000

var MSPEED = 0

var dashtimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.player = self
	pass # Replace with function body.


func inputget():
	
	if Input.is_action_pressed("ui_right"):
		$ANIM.play("run")
		MSPEED = WALKSPEED
		$ANIM.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		$ANIM.play("run")
		MSPEED = -WALKSPEED
		$ANIM.flip_h = true
	else:
		$ANIM.play("idle")
		MSPEED = 0
	if Input.is_action_just_pressed("dash"):
		dashtimer = 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	inputget()
	
	VELOCITY.y = move_and_slide_with_snap(VELOCITY * delta, SNAPVEC, Vector3.UP, true,5, 64.0).y
	#VELOCITY.x = move_and_slide(VELOCITY * delta, UP, true).x
	
	VELOCITY = VELOCITY.rotated(Vector3.UP, $Camera.rotation.y)
	
	VELOCITY.x = MSPEED
	
	if !is_on_floor():
		VELOCITY.y -= GRAVITY * delta
	
	if dashtimer > 0:
		dashtimer -= 1
	
#	pass



