extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum wawa{
	IDLE,
	SHOOT,
	STOMP,
	SLIDE,
	WALK,
	DIE
}


const SNAPDIR = Vector2.DOWN
var SNAPLEN = 24.0

export var states = wawa

export var dir = -1

export var detected = false

var idletimer = 0

var rng = RandomNumberGenerator.new()
var choice = rng.randi_range(0,3)

var motion = Vector2(0,0)

var snapvec = SNAPDIR * SNAPLEN

var runtimer = 0

var gravity = 500

var Up = Vector2.UP

var hp = 50

var floormax = deg2rad(64.0)

var hits = 0

var dashtimer = 0

export var flip = false

# Called when the node enters the scene tree for the first time.
func _ready():
	states = "IDLE"
	$Health.visible = false
	$Health/ProgressBar.min_value = 0
	$Health/ProgressBar.max_value = 50
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hp <= 0 && $ForeSight/AnimationPlayer.current_animation != "Die":
		states = "DIE"
		$Health.visible = false
		Globals.music.stream = null
#	pass
	
	rng.randomize()
	
	$Health/ProgressBar.value = hp
	
	if states != "SLIDE" && states != "DIE":
		match(dir):
			-1:
				$ForeSight.scale.x = 1
			1:
				$ForeSight.scale.x = -1
	
	print_debug(scale.x)
	
	#print_debug(str(hp))
	
	if detected && states != "SLIDE" && states != "DIE":
		position.x = clamp(position.x, Globals.camera.limit_left + 50, Globals.camera.limit_right)
		decision(delta)
		$Health.visible = true
		if Globals.playerpos.x < position.x -1:
			dir = -1
			
		if Globals.playerpos.x > position.x +1:
			dir = 1
			
	
	
	if detected && idletimer > 0:
		idletimer -= 1
		
		
	if idletimer > 0:
		states = "IDLE"
	
	if states == "WALK":
		if runtimer <= 0:
			states = "IDLE"
		else:
			runtimer -= 1
	
	if dashtimer >= 0:
		dashtimer -= 1
	else:
		if states == "SLIDE":
			attack()
	
	match(states):
		"IDLE":
			$ForeSight/AnimationPlayer.play("idle")
			motion.x = 0
			
		"WALK":
			$ForeSight/AnimationPlayer.play("Walk")
			motion.x = 150 * dir
			
		"SLIDE":
			hits = 0
			$ForeSight/AnimationPlayer.play("slide")
			motion.x = 400 * dir
			
		"SHOOT":
			$ForeSight/AnimationPlayer.play("Shoot")
			motion.x = 0
		
		"STOMP":
			$ForeSight/AnimationPlayer.play("Stomp")
			motion.x = 0
		
		"DIE":
			$ForeSight/AnimationPlayer.play("Die")
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

func camshake():
	Globals.camera.shake(1200,1,300)
	

func shoot():
	
	$ForeSight/Spawn.play()
	var BulletA = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	var BulletB = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	var BulletC = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	
	BulletA.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletB.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletC.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	
	
	BulletA.global_position = $ForeSight/Head/Shoulderfront/ArmFront/ArmpieceFront/Position2D.global_position
	BulletB.global_position = $ForeSight/Head/Shoulderfront/ArmFront/ArmpieceFront/Position2D.global_position
	BulletC.global_position = $ForeSight/Head/Shoulderfront/ArmFront/ArmpieceFront/Position2D.global_position
	
	
	get_parent().add_child(BulletA)
	
	get_parent().add_child(BulletB)
	
	get_parent().add_child(BulletC)
	

func decision(delta):
	
	if hits >= 20:
		dashtimer = 20
		states = "SLIDE"
		
	if states == "IDLE" && idletimer <= 0:
		choice = rng.randi_range(0, 2)
		match(choice):
			0:
				attack()
			1:
				runtimer = 50
				states = "WALK"
			2:
				dashtimer = 20
				states = "SLIDE"

func attack():
	choice = rng.randi_range(0,3)
	print_debug(choice)
	match(choice):
		0:
			states = "SHOOT"
		1:
			states = "STOMP"
		2:
			states = "SLIDE"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Shoot":
		idletimer = 60
		states = "IDLE"
	
	if anim_name == "Stomp":
		idletimer = 60
		states = "IDLE"
		
	if anim_name == "slide":
		idletimer = 60
		states = "IDLE"
		
	if anim_name == "Walk":
		idletimer = 60
		states = "IDLE"
	


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
		if !Globals.stuntList.empty():
			if Globals.player.is_on_floor():
				Globals.stuntList.append("GroundedKill")
			else:
				Globals.stuntList.append("AerialKill")

func _on_Hurtbox_area_entered(area):
	if hp > 0:
		
		if area.is_in_group("hit1"):
			$ForeSight/Head/Conditionplayer.play("damage")
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			hp -= 0.8 + Globals.atkmult
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.8 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$ForeSight/hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)

			
		if area.is_in_group("slash"):
			$ForeSight/Head/Conditionplayer.play("damage")
			hp -= 0.5 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.5 + Globals.atkmult)
			get_parent().add_child(damobj)
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$ForeSight/hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)


			
		if area.is_in_group("hit2"):
			$ForeSight/Head/Conditionplayer.play("damage")
			hp -=  1 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			$ForeSight/hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)

			
			
		if area.is_in_group("hit3"):
			$ForeSight/Head/Conditionplayer.play("damage")
			hp -= 0.4 + Globals.atkmult
			
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.4 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			#$multihurt.start()
			#$multihurtrepeat.start()
			$ForeSight/hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)
				
		if area.is_in_group("enemproject"):
			$ForeSight/Head/Conditionplayer.play("damage")
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
			
			
			$ForeSight/hurt.play()
			Globals.score += 100
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				Globals.score += 600
#
			
			
		if area.is_in_group("airhit"):
			$ForeSight/Head/Conditionplayer.play("damage")
			hp -= 1 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			#$multihurt.start()
			#$multihurtrepeat.start()
			$ForeSight/hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)


		if area.is_in_group("BIGDAMAGE"):
			$ForeSight/Head/Conditionplayer.play("damage")
			hp -= 7 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(7 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$ForeSight/hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)


	

func _on_multihurt_timeout():
	$multihurtrepeat.stop()
	


func _on_Area2D_area_exited(area):
	$multihurt.stop()


func _on_multihurtrepeat_timeout():
	if !$multihurt.is_stopped():
		if hp > 0:
			$multihurtrepeat.start()
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$ForeSight/hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			hp -= 0.3 + Globals.atkmult
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(hp - 0.3 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			if hp > 0:
				frameFreeze(0.05, 0.3)

func gonow():
	Switches.foresightdefeated = 1

func _on_Conditionplayer_animation_finished(anim_name):
	if anim_name == "damage":
		$ForeSight/Head/Conditionplayer.play("normal")
	pass # Replace with function body.
