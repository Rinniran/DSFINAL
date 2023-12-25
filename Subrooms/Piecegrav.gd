extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var move = Vector2.ZERO
var speed = 450

export var magnet = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if $Piece.kill:
		queue_free()
	if $Piece/Detect.active && magnet == true:
		move = position.direction_to($"/root/Globals".player.position) * speed
		move_and_slide(move)
#	pass
