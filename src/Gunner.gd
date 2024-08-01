extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum wawa{
	IDLE,
	DETECT,
	RUN,
	JUMP,
	FALL,
	SHOOT,
	MELEE,
	HURT,
	DIE
}


const SNAPDIR = Vector2.DOWN
var SNAPLEN = 24.0

export var states = wawa

export var dir = 1

var detected = false

var idletimer = 0

var motion = Vector2(0,0)

var snapvec = SNAPDIR * SNAPLEN

var runtimer = 0

var gravity = 500

var Up = Vector2.UP

var floormax = deg2rad(64.0)

var hp = 5


export var flip = false

# Called when the node enters the scene tree for the first time.
func _ready():
	states = "IDLE"
	
	$Sprite.flip_h = flip
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	decision(delta)
	
	if !is_on_floor():
		motion.y += gravity * delta
	
	match($Sprite.flip_h):
		true:
			dir = 1
			$Sight.scale.x = -1
		false:
			dir = -1
			$Sight.scale.x = 1
	
	
	#print_debug(str(hp))
	
	if detected:
		if Globals.playerpos.x < position.x -1:
			 $Sprite.flip_h = false
		if Globals.playerpos.x > position.x +1:
			 $Sprite.flip_h = true
	
	if detected && idletimer > 0:
		idletimer -= 1
		
		
	if idletimer > 0:
		states = "IDLE"
	
	if states == "RUN":
		if runtimer <= 0:
			states = "IDLE"
		else:
			runtimer -= 1
	
	match(states):
		"IDLE":
			$AnimationPlayer.play("Idle")
			motion.x = 0
		"DETECT":
			detected = true
			$AnimationPlayer.play("Detected")
			motion.x = 0
			
		"RUN":
			$AnimationPlayer.play("Run")
			motion.x += 2.4 * dir
		"JUMP":
			$AnimationPlayer.play("Jump")
		"FALL":
			$AnimationPlayer.play("Fall")
		"SHOOT":
			$AnimationPlayer.play("Shoot")
			motion.x = 0
		"MELEE":
			$AnimationPlayer.play("Melee")
			motion.x = 0
		"HURT":
			
			$AnimationPlayer.play("Hurt1")
			detected = true
			motion.x = 0
		"DIE":
			$AnimationPlayer.play("Die")
			if !Globals.stuntList.empty():
				if Globals.player.is_on_floor():
					Globals.stuntList.append("GroundedKill")
				else:
					Globals.stuntList.append("AerialKill")
			motion.x = 0
	
	motion.y = move_and_slide_with_snap(motion, snapvec, Up, true, 6, floormax, false).y
	
	
	if hp <= 0:
		states = "DIE"
	
#	pass



func decision(delta):
	if states != "HURT":
		if states == "IDLE" && detected && idletimer <= 0:
			if Globals.playerpos.x < position.x -200:
				runtimer = 20
				states = "RUN"
			elif Globals.playerpos.x < position.x -80:
				states = "SHOOT"
			elif Globals.playerpos.x < position.x -1:
				states = "MELEE"
			
			if Globals.playerpos.x > position.x +200:
				runtimer = 20
				states = "RUN"
				
			elif Globals.playerpos.x > position.x +80:
				states = "SHOOT"
			elif Globals.playerpos.x > position.x +1:
				states = "MELEE"
		
		if states == "RUN" && detected && runtimer <= 0:
			if Globals.playerpos.x < position.x -200:
				runtimer = 20
				states = "RUN"
			elif Globals.playerpos.x < position.x -80:
				states = "SHOOT"
			elif Globals.playerpos.x < position.x -1:
				states = "MELEE"
			
			if Globals.playerpos.x > position.x +200:
				runtimer = 20
				states = "RUN"
				
			elif Globals.playerpos.x > position.x +80:
				states = "SHOOT"
			elif Globals.playerpos.x > position.x +1:
				states = "MELEE"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Melee":
		idletimer = 10
		states = "IDLE"
	
	if anim_name == "Shoot":
		idletimer = 10
		states = "IDLE"
	
	if anim_name == "Detected":
		
		idletimer = 10
		states = "IDLE"
		
	
	if anim_name == "Hurt1":
		idletimer = 10
		states = "IDLE"
	
	if anim_name == "Die":
		
		queue_free()
	


func _on_Sight_area_entered(area):
	if area.is_in_group("hurtbox") && detected == false:
		states = "DETECT"



func endit():
	queue_free()
func frameFreeze(timeScale, duration):
	
	
	if hp <= 0:
		var DS = preload("res://Subrooms/Dspark.tscn")
		var buble = DS.instance()
		buble.position = global_position
		get_parent().add_child(buble)
	Globals.canthurt = 1
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
	Globals.canthurt = 0
	var diesound = preload("res://Audio/SE/Enemdie.wav")
	#Globals.atkmult += (.3)
	if hp <= 0:
		Globals.score += 40
		states = "DIE"
		Globals.stuntTimer = 30
		if !Globals.stuntList.empty():
			if Globals.player.is_on_floor():
				Globals.stuntList.append("GroundedKill")
			else:
				Globals.stuntList.append("AerialKill")


func shoot():
	var BulletA = preload("res://Subrooms/Basic Proj.tscn").instance()
	var BulletB = preload("res://Subrooms/Basic Proj.tscn").instance()
	var BulletC = preload("res://Subrooms/Basic Proj.tscn").instance()
	
	
	
	BulletA.mode = 1
	BulletB.mode = 2
	BulletC.mode = 3
	
	get_parent().add_child(BulletA)
	
	get_parent().add_child(BulletB)
	
	get_parent().add_child(BulletC)
	if dir == -1:
		BulletA.position.x = position.x - 32
		BulletA.position.y = position.y
		BulletB.position.x = position.x - 32
		BulletB.position.y = position.y
		BulletC.position.x = position.x - 32
		BulletC.position.y = position.y
		
		BulletA.scale.x = -0.5
		BulletB.scale.x = -0.5
		BulletC.scale.x = -0.5


	if dir == 1:
		BulletA.position.x = position.x + 32
		BulletA.position.y = position.y
		BulletB.position.x = position.x + 32
		BulletB.position.y = position.y
		BulletC.position.x = position.x + 32
		BulletC.position.y = position.y
		BulletA.scale.x = 0.5
		BulletB.scale.x = 0.5
		BulletC.scale.x = 0.5


func _on_Hurt_area_entered(area):
	if states != "DIE":
		if area.is_in_group("hit1"):
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			hp -= 0.8 + Globals.atkmult
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.8 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)

			
		if area.is_in_group("slash"):
			hp -= 0.5 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.5 + Globals.atkmult)
			get_parent().add_child(damobj)
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)


			
		if area.is_in_group("hit2"):
			hp -=  1 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)

			
			
		if area.is_in_group("hit3"):
			hp -= 0.4 + Globals.atkmult
			
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.4 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			$multihurt.start()
			$multihurtrepeat.start()
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)
				
		if area.is_in_group("enemproject"):
			Globals.groovePoints += Globals.grooveWorth * 2
			Globals.grooveTimer = Globals.grooveTimerMax
			Globals.grooveList.append("FriendlyFire")
			Globals.grooveList.pop_front()
			hp -= 2 
			Globals.combotimer = 60 * 10
			Globals.combo += 4
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(2 + Globals.atkmult)
			get_parent().add_child(damobj)
			$AnimationPlayer.stop(true)
			
			states = "HURT"
			Globals.score += 100
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				Globals.score += 600
	#
			
			
		if area.is_in_group("airhit"):
			hp -= 1 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			$multihurt.start()
			$multihurtrepeat.start()
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)


		if area.is_in_group("BIGDAMAGE"):
			hp -= 7 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(7 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)
