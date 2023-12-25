extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var path_follow = get_parent()

export var _speed = 800

var goback = 0

var move = 0

export var endval = 0

export var dirx = 1

export var diry = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if move == 0:
		$Sprite.play("default")
	if goback == 0 && move == 1:
		$Sprite.play("moving")
		Globals.player.jumpdash = 1
		Globals.player.global_position.x = global_position.x + 32
		Globals.player.global_position.y = global_position.y
		Globals.player.motion.x = _speed * dirx
		Globals.player.motion.y = _speed / 4 * diry
		path_follow.offset += _speed * delta
	
	if path_follow.offset >= endval:
		goback = 1
		
		
	if path_follow.offset == 0:
		move = 0
		goback = 0
		
	if goback == 1:
		$Sprite.play("stop")
		path_follow.offset -= 200 * delta
		
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		if Globals.player.dashing || Globals.player.jumpdash:
			path_follow.offset = 1
			move = 1
	pass # Replace with function body.
