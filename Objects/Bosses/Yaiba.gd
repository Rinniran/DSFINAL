extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum wawa{
	IDLE,
	TELBLUE,
	TELRED,
	TELGREEN,
	WALK,
	JUMP,
	FALL,
	SLICE,
	SUMMON,
	HURT,
	DIE
}


const SNAPDIR = Vector2.DOWN
var SNAPLEN = 24.0

export var states = wawa

export var dir = 1

export var detected = false

var idletimer = 0

var rng = RandomNumberGenerator.new()
var choice = rng.randi_range(0,3)

var motion = Vector2(0,0)

var snapvec = SNAPDIR * SNAPLEN

var runtimer = 0

var gravity = 500

var Up = Vector2.UP

var floormax = deg2rad(64.0)

var hp = 150

var hits = 0

var dashtimer = 0

export var flip = false

var organichurt = preload("res://Audio/SE/OrganicHurt.wav")
var organicNL = preload("res://Audio/SE/OrganicNL.mp3")
var crit = preload("res://Audio/SE/CRIT.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	states = "IDLE"
	$Health.visible = false
	$Health/ProgressBar.min_value = 0
	$Health/ProgressBar.max_value = hp + 30
	$Sprite.flip_h = flip
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if motion.y > 0 && states != "DIE":
		states = "FALL"
	
	if !is_on_floor():
		motion.y += gravity * delta
	
	if states != "DASH" && states != "DIE":
		match($Sprite.flip_h):
			true:
				dir = 1
			false:
				dir = -1
	
	
	$Health/ProgressBar.value = hp
	
	print_debug(states)
	
	if detected && states != "DIE":
		$Health.visible = true
		position.x = clamp(position.x, Globals.camera.limit_left + 20, Globals.camera.limit_right)
		decision(delta)
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
	
	if dashtimer >= 0:
		dashtimer -= 1
	else:
		if states == "DASH":
			attack()
	
	match(states):
		"IDLE":
			$AnimationPlayer.play("Idle")
			motion.x = 0
		"TELBLUE":
			$AnimationPlayer.play("TelegraphBlue")
			motion.x = 0
		"TELRED":
			$AnimationPlayer.play("TelegraphRed")
			motion.x = 0
		"TELGREEN":
			$AnimationPlayer.play("TelegraphGreen")
			motion.x = 0
			
		"WALK":
			$AnimationPlayer.play("Walk")
			motion.x = 200 * dir
			
		"DASH":
			hits = 0
			$AnimationPlayer.play("dash")
			motion.x = 600 * dir
			
		"JUMP":
			$AnimationPlayer.play("Jump")
			motion.y -= 200
			states = "IDLE"
		"FALL":
			$AnimationPlayer.play("Fall")
		"SLICE":
			$AnimationPlayer.play("Slash")
			motion.x = 0
		"SUMMON":
			$AnimationPlayer.play("Summon")
			
			motion.x = 0
		"HURT":
			detected = true
			$AnimationPlayer.play("Hurt")
			motion.x = 0
		"DIE":
			$Health.visible = false
			$Sprite.flip_h = false
			Switches.YaibaDefeated = 1
			$AnimationPlayer.play("Die")
			if !Globals.stuntList.empty() && is_instance_valid(Globals.player):
				if Globals.player.is_on_floor():
					Globals.stuntList.append("GroundedKill")
				else:
					Globals.stuntList.append("AerialKill")
			motion.x = 0
	
	if hp > 0:
		motion.y = move_and_slide_with_snap(motion, snapvec, Up, true, 6, floormax, false).y
	
	if hp <= 0:
		states = "DIE"
		$AnimationPlayer.play("Die")
		
	
#	pass



func decision(delta):
	
	if hits >= 10:
		dashtimer = 20
		states = "DASH"
		
	if states == "IDLE" && idletimer <= 0:
		choice = rng.randi_range(0, 4)
		match(choice):
			0:
				attack()
			1:
				runtimer = 20
				states = "WALK"
			2:
				dashtimer = 20
				states = "DASH"
			3:
				if !is_on_floor():
					states = "JUMP"
				else: 
					attack()
			4:
				states = "SLICE"
		
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Slash":
		idletimer = 20
		states = "IDLE"
	
	if anim_name == "TelegraphBlue":
		slashblue()
		states = "SLICE"
		
	if anim_name == "TelegraphRed":
		slashred()
		states = "SLICE"
		
	if anim_name == "TelegraphGreen":
		slashgreen()
		states = "SLICE"
	
	if anim_name == "Summon":
		states = "WALK"
		var runbuddy = preload("res://Objects/Hazards/Crosshair.tscn").instance()
		get_parent().add_child(runbuddy)
		
	
	if anim_name == "Hurt":
		idletimer = 25
		states = "IDLE"
	

	


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


func slashblue():
	$Spawn.play()
	var BulletA = preload("res://Objects/Hazards/YaibaSlash.tscn").instance()
	var BulletB = preload("res://Objects/Hazards/YaibaSlash.tscn").instance()
	var BulletC = preload("res://Objects/Hazards/YaibaSlash.tscn").instance()
	
	
	
	BulletA.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletB.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletC.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	
	BulletA.global_position = global_position
	BulletB.global_position = global_position
	BulletC.global_position = global_position
	
	get_parent().add_child(BulletA)
	
	get_parent().add_child(BulletB)
	
	get_parent().add_child(BulletC)

func slashred():
	$Spawn.play()
	var BulletA = preload("res://Objects/Hazards/YaibaKillSlash.tscn").instance()
	var BulletB = preload("res://Objects/Hazards/YaibaKillSlash.tscn").instance()
	var BulletC = preload("res://Objects/Hazards/YaibaKillSlash.tscn").instance()
	
	
	
	BulletA.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletB.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletC.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	
	
	BulletA.global_position = global_position
	BulletB.global_position = global_position
	BulletC.global_position = global_position
	get_parent().add_child(BulletA)
	
	get_parent().add_child(BulletB)
	
	get_parent().add_child(BulletC)

func slashgreen():
	
	$Spawn.play()
	var BulletA = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	var BulletB = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	var BulletC = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	
	
	var BulletD = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	var BulletE = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	var BulletF = preload("res://Objects/Hazards/YaibaMissile.tscn").instance()
	
	BulletA.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletB.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletC.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletD.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletE.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	BulletF.start(Transform2D(Vector2(dir,0),Vector2(0,1),Vector2(0,0)))
	
	
	BulletA.global_position = global_position
	BulletB.global_position = global_position
	BulletC.global_position = global_position
	
	BulletD.global_position = global_position
	BulletE.global_position = global_position
	BulletF.global_position = global_position
	
	get_parent().add_child(BulletA)
	
	get_parent().add_child(BulletB)
	
	get_parent().add_child(BulletC)
	
	get_parent().add_child(BulletD)
	
	get_parent().add_child(BulletE)
	
	get_parent().add_child(BulletF)

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
			
			$Sounds.stream = organichurt
			$Sounds.play()
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			hits += 1
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
			$Sounds.stream = organichurt
			$Sounds.play()
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			hits += 1
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
			$Sounds.stream = organicNL
			$Sounds.play()
			get_parent().add_child(ma)
			hits += 1
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
			$Sounds.stream = organichurt
			$Sounds.play()
			get_parent().add_child(ma)
			hits += 1
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
			
			$Sounds.stream = organichurt
			$Sounds.play()
			
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
			hits += 1
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
			$Sounds.stream = organichurt
			$Sounds.play()
			$multihurtrepeat.start()
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			hits += 1
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
			
			$Sounds.stream = crit
			$Sounds.play()
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$AnimationPlayer.stop(true)
			states = "HURT"
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			hits += 1
			if hp > 0:
				frameFreeze(0.05, 0.3)

func attack():
	choice = rng.randi_range(0,3)
	print_debug(choice)
	match(choice):
		0:
			states = "TELBLUE"
		1:
			states = "TELRED"
		2:
			states = "TELGREEN"
		3:
			states = "SUMMON"

func _on_multihurtrepeat_timeout():
	pass # Replace with function body.


func _on_multihurt_timeout():
	pass # Replace with function body.
