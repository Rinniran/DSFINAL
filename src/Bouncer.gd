extends Area2D


export var dir = 0

var pl = Globals.player

export var speed = 300

var timer = 0

var setme = 0
# Called whe25n the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer > 0 && $CollisionShape2D.disabled == true:
		timer -= 1
		Globals.player.jumpdash = 1
	
	if timer <= 0 && setme == 1:
		$CollisionShape2D.disabled = false
		Globals.moveenabled = 1
		Globals.player.jumpdash = 1
		setme = 0
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox"):
		Globals.player.leaving = 1
		
		Globals.player.motion.x = 0
		Globals.player.motion.y = 0
		if Globals.player.dashing:
			
			Globals.player.dashing = 0
		$CollisionShape2D.disabled = true
		Globals.moveenabled = 0
		timer = 25
		setme = 1
					
		match(dir):
			0:
				
				Globals.player.motion.y = -speed
				
			1:
				Globals.player.motion.y = -speed
				Globals.player.MSPEED = speed
				Globals.player.motion.x = 1 * Globals.player.MSPEED
			2:
				Globals.player.MSPEED = speed
				Globals.player.motion.x = 1 * Globals.player.MSPEED 
			3:
				Globals.player.motion.y = speed
				Globals.player.MSPEED = speed
				Globals.player.motion.x = 1 * Globals.player.MSPEED
				
			4:
				Globals.player.motion.y = speed
			5:
				Globals.player.motion.y += speed
				Globals.player.MSPEED = speed
				Globals.player.motion.x = -1 * Globals.player.MSPEED
			6:
				Globals.player.MSPEED = speed
				Globals.player.motion.x = -1 * Globals.player.MSPEED
			7:
				Globals.player.motion.y -= speed
				Globals.player.motion.x = -1 * Globals.player.MSPEED
		
		Globals.player.snapoffexternal()
		
		
	pass # Replace with function body.
