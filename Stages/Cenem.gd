extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = Vector2()
var move = Vector3.ZERO
var speed = 100
var dielol = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	if $Chaser.active && (position.x < Globals.camera.limit_left || position.x > Globals.camera.limit_right || position.y < Globals.camera.limit_top || position.y > Globals.camera.limit_bottom):
		queue_free()
	
	if $Chaser.dead == 1:
		
		queue_free()
		
		
	if $Chaser.active && !Globals.incutscene:
		
		if position != Globals.playerpos && !dielol:
			move = position.direction_to(Globals.playerpos) * speed
			move_and_slide(move)
		
		
		if get_slide_count() > 0:
			var collision = get_slide_collision(0)
			if collision != null:
				direction = direction.bounce(collision.normal) # do ball bounce
#	pass
