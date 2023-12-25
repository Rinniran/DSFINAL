extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var speed := 8.0
export var jump_strength := 1.0
const Up = Vector2.UP
var gravity := 1100.0 
const SNAPDIR = Vector2.DOWN
var SNAPLEN = 32.0
const MAXFALLSPEED = 200 / 2
const MAXSPEED = 200
var SUPERSPEED = 300
var WAVESPEED = 600 / 2
const ATKMSPEED = 150 / 2
const ZOOMSPEED = 800
var MSPEED
const floormax = deg2rad(64)
const JUMPf = 400
var yspeed = 0
var snapvec = SNAPDIR * SNAPLEN
var velocity = Vector2.ZERO
export var deacc = 5
export var acc = 40
var leaving = 0
var leavetimer = 20
var dashtimer = 60
export var dashing = 0
var motion = Vector2()
var dashes = 2
var character
var jumps = 1
var atkpts = 3
var facedir = 1
var atkg = 0
var atka = 0
var atkdashv = 0
var stopit = 0
var onevoice = 1
var jumpdash = 0
var wavedashing = 0
var zooming = 0
var zoomdir = 0
var parttimer = 2
var speedup = 1
var jumping = false

var maxpow = 1

onready var MPAura = preload("res://Maxpow.tres")
onready var Uhoh = preload("res://Damaged.tres")

var replay = []
var memory = {"L":0, "U":0, "D":0, "R":0, "Jump":0, "Attack":0, "Dash":0}
var frames = 0

var slashallowed = 1

var hurt = 0

#=====================================PRELOADS================================


var spvoice = preload("res://Audio/Voices/speedup.wav")


var whee = preload("res://Audio/Voices/full power.wav")

var blast = preload("res://Audio/SE/Waveboost.wav")
var Dsounder = preload("res://Audio/SE/dash.wav")

var wav1 = preload("res://Audio/Voices/Wdash1.wav")
var wav2 = preload("res://Audio/Voices/Wdash2.wav")
var wav3 = preload("res://Audio/Voices/Wdash3.wav")
var wav4 = preload("res://Audio/Voices/Wdash4.wav")
var wb = preload("res://Audio/SE/Waveboost.wav")

var dodgev1 = preload("res://Audio/Voices/Dodge1.wav")
var dodgev2 = preload("res://Audio/Voices/Dodge2.wav")
var dodgev3 = preload("res://Audio/Voices/Dodge3.wav")
var dodgev4 = preload("res://Audio/Voices/Dodge4.wav")
var dodgev5 = preload("res://Audio/Voices/Dodge5.wav")
var dodges = preload("res://Audio/SE/JDodge.wav")

var atkv1 = preload("res://Audio/Voices/atkproj1.wav")
var atkv2 = preload("res://Audio/Voices/atkproj2.wav")
var atkv3 = preload("res://Audio/Voices/atkproj3.wav")
var atkv4 = preload("res://Audio/Voices/atkproj4.wav")

var peece = preload("res://Audio/SE/402767__mattix__8bit-coin-03.wav")
var wunup = preload("res://Audio/SE/1up.wav")

var dam1 = preload("res://Audio/Voices/damage 1.wav")
var dam2 = preload("res://Audio/Voices/damage 2.wav")
var dam3 = preload("res://Audio/Voices/damage 3.wav")
var die = preload("res://Audio/Voices/Rded4.ogg")

var thing = preload("res://Objects/UI/Pause.tscn")

var slash = preload("res://Objects/Air_Slash.tscn")
var dust = preload("res://Subrooms/dust.tscn")
var atkfx = preload("res://Stages/Attackfx1.tscn")


#==================== DEMO INPUTS ===================
var jump = false



#const UP_DIRECTION := Vector2.UP
func _ready():
	#camera = get_node("SpringArm").get_global_transform()
	character = get_node(".")
	$"/root/Globals".register_player(self)
	Globals.checkpX = position.x
	Globals.checkpY = position.y



func getInput():
	if Input.is_action_just_pressed("jump"):
		jump()



func _physics_process(delta) -> void:
	#print_debug(Globals.incutscene)
	#=================== DEMO INPUTS ==========================
#	if Input.is_action_just_pressed("ui_left"): memory.L = frames
#	if Input.is_action_just_pressed("ui_right"): memory.R = frames
#	if Input.is_action_just_pressed("ui_up"): memory.U = frames
#	if Input.is_action_just_pressed("ui_down"): memory.D = frames
#	if Input.is_action_just_pressed("attack"): memory.Attack = frames
#	if Input.is_action_just_pressed("dash"): memory.Dash = frames
#
#	if Input.is_action_just_released("ui_left"): replay.append({"key":"L", "startframe":memory.L, "endframe":frames})
#	if Input.is_action_just_released("ui_right"): replay.append({"key":"R", "startframe":memory.R, "endframe":frames})
#	if Input.is_action_just_released("ui_up"): replay.append({"key":"U", "startframe":memory.U, "endframe":frames})
#	if Input.is_action_just_released("ui_down"): replay.append({"key":"D", "startframe":memory.D, "endframe":frames})
#	if Input.is_action_just_released("jump"): replay.append({"key":"Jump", "startframe":memory.Jump, "endframe":frames})
#	if Input.is_action_just_released("attack"): replay.append({"key":"Attack", "startframe":memory.Attack, "endframe":frames})
#	if Input.is_action_just_released("dash"): replay.append({"key":"Dash", "startframe":memory.Dash, "endframe":frames})
#
	#=========================== INPUTS==============================
	#var Kaggro = Input.is_action_pressed("aggro")
	var Kpause = Input.is_action_pressed("pause")
	#var deb1 = Input.is_action_just_pressed("hpdown")
	#var deb2 = Input.is_action_just_pressed("hpup")
	#var alt = Input.is_action_just_pressed("but_alt")
	var Kgrab = Input.is_action_pressed("grab")
	#var go = Input.is_action_pressed("jump")
	
	Globals.playerpos = global_position
	
	
	
	#================== PAUSE THE GAME ========================
	
	if Kpause && Globals.paused == 0:
		
		get_parent().add_child(thing.instance())
	
	
	getInput()
	
	
	handleDeath()
	
	KnockbackHandler()
	position.x = clamp(position.x,Globals.camera.limit_left + 20,Globals.camera.limit_right)
	
	if Kgrab && Globals.cantalk == true && Globals.moveenabled == 1:
			Globals.moveenabled = 0
			Globals.visibox = true
			if $Rspr.animation != "stop":
				$Rspr.play("stop")
	
	Globals.camera.rotation_degrees = $Rspr.rotation_degrees
	
	altAnims()
	
	
	
	SUPERSPEED = 600
	WAVESPEED = 1800 / 2
	
	if Globals.incutscene == 1:
		Globals.moveenabled = 0
	
	if !Globals.incutscene:
		if Globals.ded == 0:
			jumpHandler()
			hitboxHandler()
			dashHandler(delta)
			zoomHandler()
			
			motion.x = clamp(motion.x, -MSPEED,MSPEED)
			
			sprScaleJumping()
			inputHandler()
			groundedHandler()
			
			if $snapoff.is_stopped():
				leaving = 0
				
			if dashtimer > 0:
				dashtimer -= (1 / delta * Engine.time_scale)
				if dashtimer <= 0:
					leavetimer = 0
					atkg = 0
					dashing = 0
					
			motion.y = move_and_slide_with_snap(motion, snapvec, Up, true, 6, floormax, false).y
			 
			airHandler()
			
			
		
		if position.y > Globals.camera.limit_bottom + 24:
			Globals.hpcount = 0
		
	if !is_on_floor() && jumping == false && dashing:
		jumpdash = 1





func _on_Rspr_animation_finished():
	if $Rspr.animation == "attackg_a" || $Rspr.animation == "dash" && dashing == 0 || $Rspr.animation == "BDash" && dashing == 0 || $Rspr.animation == "waveburst" && zooming == 0:
		atkg = 0 
		$groundatk/CollisionShape2D.disabled = true
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else:
			$Rspr.play("idle")
	elif $Rspr.animation == "attackg_b":
		atkg = 0
		$groundatk2/CollisionShape2D.disabled = true
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else:
			$Rspr.play("idle")
	elif $Rspr.animation == "attackg_c":
		atkg = 0 
		$attack3hit/CollisionShape2D.disabled = true
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else:
			$Rspr.play("idle")
		atkpts = 3
	elif $Rspr.animation == "attackair":
		atka = 0
		$airatk/CollisionShape2D.disabled = true
		$Rspr.play("idle") #replace with the air animations!
	elif $Rspr.animation == "airdash":
		atkg = 0
		$Rspr.play("idle") #replace with the air animations!
	elif $Rspr.animation == "stop":
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else:
			$Rspr.play("idle")
	elif $Rspr.animation == "damage":
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else:
			$Rspr.play("idle")
		Globals.moveenabled = 1


var shakeamount = 0
func camshake():
	var intensity = 0.5
	var duration = 0.2
	
	








#=================== HANDLER FUNCTIONS ===============================
func altAnims():
	if $Rspr.animation == "Fjump":
		if $Rspr.flip_h == true:
			$Rspr.rotation_degrees -= 8
		if $Rspr.flip_h == false:
			$Rspr.rotation_degrees += 8
	else:
		$Rspr.rotation_degrees = 0
	
	if $Rspr.animation == "airdash":
		if (Input.is_action_pressed("ui_strafe")):
			if motion.x < 0 && $Rspr.flip_h == false || motion.x > 0 && $Rspr.flip_h == true:
				$Rspr.play("BDash2")


func airHandler():
	if !is_on_floor():
		if motion.y > 0 && !dashing && $Rspr.animation != "attackair":
			if ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == false && motion.x < 1 || ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == true && motion.x > 1 && $damagepause.is_stopped():
				$Rspr.play("BJump")
				
			elif ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == true && motion.x < 1 || ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == false && motion.x > 1 && $damagepause.is_stopped():
				$Rspr.play("Fjump")
				
			else:
				$Rspr.play("fall")
		elif motion.y < 0 && !dashing && $Rspr.animation != "attackair":
			if ((Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == false && motion.x < 1 || (Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == true && motion.x > 1) && $damagepause.is_stopped():
				$Rspr.play("BJump")
			elif ((Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == true && motion.x < 1 || (Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == false && motion.x > 1) && $damagepause.is_stopped():
				$Rspr.play("Fjump")
			elif $Rspr.animation != "Fjump" && $Rspr.animation != "Bjump" && $damagepause.is_stopped() == true:
				$Rspr.play("jump")


func hitboxHandler():
	if $groundatk2/CollisionShape2D.disabled == false:
			$groundatk/CollisionShape2D.disabled = true
		
	if $attack3hit/CollisionShape2D.disabled == false:
			$groundatk2/CollisionShape2D.disabled = true
			
	if zooming == 0 || Globals.combo < 60 && dashing == 0:
			$Zoombox/CollisionShape2D.disabled = true
		
	if atkg == 0:
			$groundatk/CollisionShape2D.disabled = true
			$groundatk2/CollisionShape2D.disabled = true
			$attack3hit/CollisionShape2D.disabled = true
		
	if atkg == 2:
			$groundatk/CollisionShape2D.disabled = true
			$groundatk2/CollisionShape2D.disabled = true
			
	if atkg == 3:
			$groundatk/CollisionShape2D.disabled = true
			$attack3hit/CollisionShape2D.disabled = true
		
	if atka == 0 || $Rspr.animation == "idle" || $Rspr.animation == "Stance" || $Rspr.animation == "run" || $Rspr.animation == "dash" || $Rspr.animation == "BDash":
			$airatk/CollisionShape2D.disabled = true


func handleDeath():
	if Globals.ded == 1:
		$Hurtbox/CollisionShape2D.disabled = true
	else:
		$Hurtbox/CollisionShape2D.disabled = false


func KnockbackHandler():
	if $damagepause.is_stopped() == false:
		$Rspr.animation = "Fling"
		Globals.moveenabled = 0
		hurt = 1
		motion.y = 0
		motion.y -=  200
		if $Rspr.flip_h:
			leaving = 1
		
			motion.x = 0
			motion.x = MSPEED
			
			$snapoff.start()
		else:
			leaving = 1
			
			motion.x = 0
			motion.x = -MSPEED
			$snapoff.start()
	#print_debug(wavedashing)
	if $damagepause.is_stopped():
		hurt = 0


func zoomHandler():
	if zooming:
				Globals.moveenabled = 0
				
				MSPEED = ZOOMSPEED
				
				
				$Zoombox/CollisionShape2D.disabled = false
				if zoomdir == 0:
					motion.y = 0
					motion.x = MSPEED
					$Rspr.play("waveburst")
				if zoomdir == 1:
					leaving = 1
					motion.y = -ZOOMSPEED
					motion.x = 0
					$Rspr.play("Fjump")

func dashCommands():
	
	if is_on_floor() && $Rspr.animation != "attackair":
		if facedir == 1:
			motion.x = MSPEED
			
		if facedir == -1:
			motion.x = -MSPEED
		
	elif (Input.is_action_pressed("ui_left") || Input.get_action_strength("stickleft")) && (Input.is_action_pressed("ui_up") || Input.get_action_strength("stickup")) && Globals.moveenabled == 1:
		motion.x = -MSPEED
		motion.y = -MSPEED
	elif (Input.is_action_pressed("ui_left") || Input.get_action_strength("stickleft")) && (Input.is_action_pressed("ui_down") || Input.get_action_strength("stickdown")) && Globals.moveenabled == 1 && !(Input.is_action_pressed("jump")):
		motion.x = -MSPEED
		motion.y = MSPEED
		if is_on_floor():
			wavedashing = 1
	elif (Input.is_action_pressed("ui_left") || Input.get_action_strength("stickleft")):
		motion.x = -MSPEED
		if is_on_floor():
			wavedashing = 1
	elif (Input.is_action_pressed("ui_right") || Input.get_action_strength("stickright")) && (Input.is_action_pressed("ui_up") || Input.get_action_strength("stickup")) && !jumpdash && Globals.moveenabled == 1:
		motion.x = MSPEED
		motion.y = -MSPEED
	elif (Input.is_action_pressed("ui_right") || Input.get_action_strength("stickright")) && (Input.is_action_pressed("ui_down") || Input.get_action_strength("stickdown")) && Globals.moveenabled == 1 && !(Input.is_action_pressed("jump")):
		motion.x = MSPEED
		motion.y = MSPEED
		if is_on_floor():
			wavedashing = 1
	elif (Input.is_action_pressed("ui_right") || Input.get_action_strength("stickright")) && !jumpdash && Globals.moveenabled == 1:
		motion.x = MSPEED
		if is_on_floor():
			wavedashing = 1
	elif (Input.is_action_pressed("ui_up") || Input.get_action_strength("stickup")) && Globals.moveenabled == 1:
		motion.y = -MSPEED
	elif (Input.is_action_pressed("ui_down") || Input.get_action_strength("stickdown")) && Globals.moveenabled == 1 && !(Input.is_action_pressed("jump")):
		motion.y = MSPEED
		if is_on_floor():
			wavedashing = 1

func jumpHandler():
	if leaving == 1:
				snapvec = Vector2(0,0)
	else:
		snapvec = SNAPDIR * SNAPLEN

func inputHandler():
	if (Input.is_action_pressed("ui_right") || Input.get_action_strength("stickright")) && Globals.moveenabled == 1:
		if is_on_floor() && !atkg && !dashing:
			if (Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == false:
				$Rspr.play("StrafeF")
			elif (Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == true:
				$Rspr.play("StrafeB")
			else:
				$Rspr.play("run")
			
		if !(Input.is_action_pressed("ui_strafe")):
			get_node("Rspr").flip_h = false
		get_node("groundatk").set_scale(Vector2(1, 1))
		get_node("groundatk2").set_scale(Vector2(1, 1))
		get_node("attack3hit").set_scale(Vector2(1, 1))
		if !atkg || dashing || jumpdash:
			
			motion.x += acc
		else:
			 
			 motion.x = 0
		facedir = 1
		
	elif (Input.is_action_pressed("ui_left") || Input.get_action_strength("stickleft")) && Globals.moveenabled == 1:
		if is_on_floor() && !atkg && !dashing:
			if ((Input.is_action_pressed("ui_strafe"))) && $Rspr.flip_h == false:
				$Rspr.play("StrafeB")
			elif (Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == true:
				$Rspr.play("StrafeF")
			else:
				$Rspr.play("run")
			
		if !(Input.is_action_pressed("ui_strafe")):
			get_node("Rspr").flip_h = true
		get_node("groundatk").set_scale(Vector2(-1, 1))
		get_node("groundatk2").set_scale(Vector2(-1, 1))
		get_node("attack3hit").set_scale(Vector2(-1, 1))
		if !atkg || dashing || jumpdash:
			
			motion.x -= acc
		else:
			 
			 motion.x = 0
		facedir = -1
	
	else:
		if is_on_floor():
			if $Rspr.animation == "run" || $Rspr.animation == "fall" || $Rspr.animation == "BJump" || $Rspr.animation == "Fjump" || $Rspr.animation == "StrafeB"|| $Rspr.animation == "StrafeF":
				atkg = 0
				if Input.is_action_pressed("ui_strafe"):
					$Rspr.play("Stance")
				else:
					$Rspr.play("idle")
				
			stopit = 0
			motion.x = lerp(motion.x,0,0.1)
		#else:
			#motion.x = lerp(motion.x,0,0.06)
			
			
			
			
			
		if (Input.is_action_just_pressed("ui_strafe")) && $Rspr.animation == "idle" && Globals.moveenabled == 1:
			if is_on_floor():
				$Rspr.play("Stance")
		
		
		if (Input.is_action_just_released("ui_strafe")) && $Rspr.animation == "Stance" && Globals.moveenabled == 1:
			if is_on_floor():
				$Rspr.play("idle")
		
			
		
			


func sprScaleJumping():
	if $Rspr.scale.x < 1:
		$Rspr.scale.x += 0.1
		if $Rspr.scale.x > 1:
			$Rspr.scale.x = 1
			
	if $Rspr.scale.y > 1:
		$Rspr.scale.y -= 0.1
		if $Rspr.scale.y < 1:
			$Rspr.scale.y = 1
	
	
	if $Rspr.scale.x > 1:
		$Rspr.scale.x -= 0.1
		if $Rspr.scale.x < 1:
			$Rspr.scale.x = 1
			
	if $Rspr.scale.y < 1:
		$Rspr.scale.y += 0.1
		if $Rspr.scale.y > 1:
			$Rspr.scale.y = 1

func dashHandler(delta):
	if dashing == 1 :
		if wavedashing && is_on_floor():
			
			MSPEED = WAVESPEED
		else:
			MSPEED = SUPERSPEED
		if $Rspr.animation == "airdash" || $Rspr.animation == "BDash2":
			motion.y = 0
			#motion.y = lerp(motion.y,0,0.001)
		
		if Globals.combo >= 60:# && Globals.superdashget
			$Zoombox/CollisionShape2D.disabled = false
		
		if atkg || Globals.combo >= 60: #&& Globals.superdashget
			var dashfx = preload("res://Stages/dashfx.tscn").instance()
			
			get_parent().add_child(dashfx)
			dashfx.position = position
			dashfx.flip_h = $Rspr.flip_h
				
			if !atkdashv:
				
				
				$dsound.set_stream(blast)
				$dsound.play()
				atkdashv = 1
				
		if Input.is_action_pressed("dash") && Globals.moveenabled == 1:
				if dashes > 0:  #&& $atkwait.is_stopped()
					dashing = 1
					$Hurtbox/dodge_window.start()
					dashtimer = 12
					if !is_on_floor():
						atka = 0
						$Rspr.play("airdash")
						dashes -= 1
					else: 
						var dust = preload("res://Subrooms/dust.tscn").instance()
						get_parent().add_child(dust)
						dust.position = position
						dust.flip_h = $Rspr.flip_h
						var Dsounder = preload("res://Audio/SE/dash.wav")
						$dsound.set_stream(Dsounder)
						$dsound.play()
		dashCommands()
				
		
		
		
	else:
		wavedashing = 0
		atkdashv = 0
		MSPEED = MAXSPEED
		motion.y += gravity * delta
		if Input.is_action_just_released("jump") && motion.y < -400 && stopit == 0:
			motion.y = -400.0
			stopit = 1
			
	if jumpdash:
		var gospeed = abs(motion.x)
		print_debug(gospeed)
		if motion.x > WAVESPEED * 2 || motion.x < -WAVESPEED * 2:
			MSPEED = gospeed
		else:
			MSPEED = SUPERSPEED
			if Globals.camera.zoom.x < 1.3:
				Globals.camera.zoom.x += 0.02
				Globals.camera.zoom.y += 0.02
	else:
		if Globals.camera.zoom.x > 1:
			Globals.camera.zoom.x -= 0.02
			Globals.camera.zoom.y -= 0.02



func groundedHandler():
	if is_on_floor():
		if !dashing:
			jumpdash = 0
		if !leaving:
			jumping = false
		dashes = 2
		slashallowed = 1
		
		
		
			
		var stream_array = [wav1, wav2, wav3, wav4, null,]
		randomize()
		var play = stream_array[randi() % stream_array.size()]
		
		if $Rspr.animation == "airdash":
			$Voices/dodgeVoices.set_stream(play)
			$Voices/dodgeVoices.play()
			$dsound.set_stream(wb)
			$dsound.play()
			wavedashing = 1
			#
		
		if $Rspr.animation != "attackg_a" && !dashing && Globals.moveenabled == 1:
				$groundatk/CollisionShape2D.disabled = true
		if $Rspr.animation != "attackg_b" && !dashing && Globals.moveenabled == 1:
				$groundatk2/CollisionShape2D.disabled = true
		if $Rspr.animation != "attackg_c" && !dashing && Globals.moveenabled == 1:
				$attack3hit/CollisionShape2D.disabled = true
				
		
			
			
		var audio_stream_array = [atkv1, atkv2, atkv3, atkv4, null, null]
		randomize()
		var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
				
		if atkpts == 3 && (Input.is_action_just_pressed("attack")) && !leaving && Globals.moveenabled == 1:
			
			$atktimer.start()
			$atkwait.start()
			atkg = 1
			atka = 0
			
	
			$Voices/dodgeVoices.set_stream(clip_to_play)
			$Voices/dodgeVoices.play()
				
			MSPEED = ATKMSPEED
			
			
			
			
			$Rspr.animation != "run"
			$Rspr.play("attackg_a")
			var atkfxinst = atkfx.instance()
			atkfxinst.position.x = position.x
			atkfxinst.position.y = position.y
			#atkfx.scale.x = 2
			#atkfx.scale.y = 2
			atkfxinst.flip_h = $Rspr.flip_h
			get_parent().add_child(atkfxinst)
			atkpts -= 1
			dashing = 0
			
			$groundatk/CollisionShape2D.disabled = true
			
		if is_on_floor() && !atkg && (Input.is_action_just_released("ui_left")) && Globals.moveenabled == 1 || is_on_floor() && !atkg && (Input.is_action_just_released("ui_right"))&& Globals.moveenabled == 1:
			$Rspr.play("stop")
			
		elif atkpts == 2 && (Input.is_action_just_pressed("attack")) && !leaving && $atkwait.is_stopped() && Globals.moveenabled == 1:
			
			$groundatk/CollisionShape2D.disabled = true
			$atktimer.start()
			$atkwait2.start()
			atkg = 3
			atka = 0
			MSPEED = ATKMSPEED
			$Rspr.animation != "run"
			$Rspr.play("attackg_b")
			dashing = 0
		
		
			$Voices/dodgeVoices.set_stream(clip_to_play)
			$Voices/dodgeVoices.play()
				
			atkpts -= 1
		elif atkpts == 1 && (Input.is_action_just_pressed("attack")) && !leaving && $killhitbox2.is_stopped() && Globals.moveenabled == 1:
			$attack3hit/CollisionShape2D.disabled = true
			$atktimer.start()
			atkg = 2
			atka = 0
			MSPEED = ATKMSPEED
			$groundatk/CollisionShape2D.disabled = true
			$attack3hit/CollisionShape2D.disabled = false
			$Rspr.animation != "run"
			
			$Voices/dodgeVoices.set_stream(clip_to_play)
			$Voices/dodgeVoices.play()
			
			$Rspr.play("attackg_c")
			atkpts -= 1
		elif dashing && motion.x != 0 && Globals.moveenabled == 1:
			if $Rspr.animation != "attackair":
				atka = 0
				if wavedashing:
					$Rspr.play("waveburst")
					if Globals.atkmult >= 3:
						$Camera2D/CanvasLayer2/spline.visible = true
				else:
					if (Input.is_action_pressed("ui_strafe")):
						if motion.x < 0 && $Rspr.flip_h == false || motion.x > 0 && $Rspr.flip_h == true:
							$Rspr.play("BDash")
						else:
							$Rspr.play("dash")
					else:
						$Rspr.play("dash")
					if Globals.atkmult >= 3:
						$Camera2D/CanvasLayer2/spline.visible = true
				
	else:
			
			if !is_on_floor():
				if (Input.is_action_just_pressed("attack")):
					atkg = 0
					if slashallowed == 1 && atka == 1:
						get_parent().add_child(slash.instance())
						slashallowed = 0
					atka = 1
					$airatk/CollisionShape2D.disabled = false
					$atktimer.start()
					#slash.flip_h += $Rspr.flip_h
					
					
					
					
					
					
			
			
					var audio_stream_array = [atkv1, atkv2, atkv3, atkv4, null, null]
					randomize()
					var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
					if $Rspr.animation != "attackair":
						$Voices/dodgeVoices.set_stream(clip_to_play)
						$Voices/dodgeVoices.play() 
						
						$Rspr.play("attackair")


#======================================================================

#========================== ACTIONS ===================================
func jump():
	if is_on_floor():
		$Rspr.scale.x = 0.2
		$Rspr.scale.y = 2
		atkg = 0
		leaving = 1
		jumping = true
		if dashing:
			
			jumpdash = 1
		motion.y /= 4
		motion.y -=  (JUMPf)
			
			
	
		#var dam1 = preload("res://Audio/Voices/damage 1.wav")
		#Globals.play_audio(1,dam1)
		
		$snapoff.start()


func _on_atktimer_timeout():
	atkpts = 3


func _on_gtimer_timeout():
	if dashing || zooming || jumpdash: #&& !Globals.incutscene
		
		var this_ghost = preload("res://Stages/ghost.tscn").instance()
		
		get_parent().add_child(this_ghost)
		
#		var particle = preload("res://Objects/Scarf_Particle.tscn").instance()
#		var particle2 = preload("res://Objects/Scarf_Particle2.tscn").instance()
#
#		parttimer -= 1
#		if parttimer == 0:
#			get_parent().add_child(particle)
#			particle.position = position
#			particle.gravity = -motion /4
#			get_parent().add_child(particle2)
#			particle2.position = position
#			particle2.gravity = -motion /4
#			parttimer = 6
		if wavedashing:
			this_ghost = preload("res://Stages/wbghost.tscn").instance()
			get_parent().add_child(this_ghost)
			this_ghost.mode = 1
		else:
			#
			this_ghost.mode = 0
		this_ghost.position = position
		this_ghost.scale.x = 1
		this_ghost.scale.y = 1
		this_ghost.rotation_degrees = $Rspr.rotation_degrees
		this_ghost.texture = $Rspr.frames.get_frame($Rspr.animation, $Rspr.frame)
		this_ghost.flip_h = $Rspr.flip_h
		
		
		#$scarfpart.emitting = false
	

func _on_atkwait_timeout():
	$groundatk/CollisionShape2D.disabled = false


func _on_atkwait2_timeout():
	$groundatk2/CollisionShape2D.disabled = false
	
	$killhitbox2.start()


func _on_killhitbox2_timeout():
	if !dashing:
		$groundatk2/CollisionShape2D.disabled = true

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0



func _on_Hurtbox_area_entered(area):
	
	
	if area.is_in_group("springhurt"):
		dashing = 0
		motion = -motion
		
		
	
	
	if area.is_in_group("Zoombox"):
		if dashing || zooming || jumpdash:
			#if Globals.Globals.link >= 30:
			#	$Camera2D/CanvasLayer2/spline.visible = true
			leaving = 1
			jumping = true
			
			zooming = 1
			if dashes == 0:
				dashes += 1
			$zoomtime.start(0.95)
	
	if area.is_in_group("bosstime"):
		Globals.incutscene = 1
		$cameracutscene.play("Yaibaintro")
	
	
	if area.is_in_group("bossmus"):
		$StageMusic.stop()
	
	if area.is_in_group("bgmon"):
		$StageMusic.play()
	
	
	if area.is_in_group("stopmusic"):
		if Globals.didakill == 0:
			$StageMusic/musichandler.play("fadeout")
		else:
			$StageMusic/musichandler.play("fadein")
	
	if area.is_in_group("enemproject") || area.is_in_group("TouchHurt") || area.is_in_group("bighurt"):
		
		var audio_stream_array = [dam1, dam2, dam3]
		randomize()
		var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
		if !dashing && !zooming && !jumpdash && Globals.canthurt == 0 || area.is_in_group("undodgeable"):
			if $damagepause.is_stopped():
				if $Hurtbox/safe_frames.is_stopped():
					if area.is_in_group("bighurt"):
							
							Globals.hpcount -= 3
							Globals.combo = 0
					if area.is_in_group("TouchHurt") && !atka || area.is_in_group("enemproject"):
						
						Globals.hpcount -= 1
						Globals.pieces -= 5
						Globals.link = 0
						Globals.combo = 0
						Globals.atkmult -= (1)
					if Globals.pieces < 0:
						Globals.pieces = 0
					if Globals.atkmult < .01:
						Globals.atkmult = .01
					if Globals.hpcount <= 0:
						$otvoice.stop()
						$Rspr.play("die")
						$otvoice.set_stream(die)
						dashing = 0 
						zooming = 0 
						jumpdash = 0
						motion.x = 0
						motion.y = 0
						Globals.ded = 1
						$otvoice.volume_db = -14
						$otvoice.play()
						$Deathwait.start()
					else:
						Globals.moveenabled = 0
						hurt = 1
						$scarfpart.gravity = motion / 4
						$scarfpart.emitting = true
						$damagepause.start()
						$Rspr.play("damage")
						$Voices/dodgeVoices.set_stream(clip_to_play)
						$Voices/dodgeVoices.play()
						atkg = 0
						
							
						
					
					
					#if Globals.hpcount == 0
		
		if dashing:
			if $Hurtbox/dodge_window.is_stopped() == false:
				
			
				audio_stream_array = [dodgev1, dodgev2, dodgev3, dodgev4, dodgev5, null, null,]
				randomize()
				clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
				$dodge.set_stream(dodges)
				$dodge.play()
				$Voices/dodgeVoices.set_stream(clip_to_play)
				$Voices/dodgeVoices.play()
				
				Globals.score += 100
				Globals.combotimer += 60 * 10
				Globals.linktimer += 60 * 10
				if Globals.combotimer > (60 * 10):
					Globals.combotimer = 60 * 10
				if Globals.linktimer > (60 * 10):
					Globals.linktimer = 60 * 10
				#frameFreeze(0.3, 0.8)
				Globals.dodged = true


func _on_damagepause_timeout():
	Globals.moveenabled = 1
	hurt = 0
	$scarfpart.emitting = false
	$scarfpart2.emitting = false
	$Hurtbox/safe_frames.start()


func _on_Deathwait_timeout():
	
	if Globals.lives > 0:
		position.x = Globals.checkpX
		position.y = Globals.checkpY
		
		#$StageMusic/musichandler.play("RESET")
		#$StageMusic.play()
		$Rspr.play("idle")
		#$Camera2D/CanvasLayer3/screenspr/Blackscreen.play("Fadein")
		
		Globals.lives -= 1
		Globals.atkmult = 0
		Globals.combo = 0
		Globals.link = 0
		Globals.hpcount = 5
		Globals.ded = 0


func _on_nowFade_timeout():
	$Camera2D/CanvasLayer2/GameoverSpr/GOAnimate.play("Gameoverend")


func _on_GOAnimate_animation_finished(anim_name):
	if anim_name == "Gameoverend":
		Sys.load_scene(Globals.cur_scene,"res://Stages/Titlescreen.tscn")
	

#func saveReplay() -> void:
#	var f = File.new()
#	var date = OS.get_datetime()
#	date = str(date.day) + "-" + str(date.month) + "-" + str(date.year) + "-" + str(date.hour) + str(date.minute) + str(date.second)
#	f.open("demo-" + date + ".Dreamplay", File.WRITE)
#	f.store_var(replay)
#	f.close()
#	return

func _on_zoomtime_timeout():
	zooming = 0
	Globals.moveenabled = 1
	#$Camera2D/CanvasLayer2/spline.visible = false


func _on_otvoice_finished():
	pass


func _on_dashatkvoice_finished():
	if Globals.link >= 30:
		speedup = 1
		
	if Globals.combo >= 60:
		maxpow = 1


func _on_Collect_area_entered(area):
	if area.is_in_group("pieceobject"):
		#Globals.atkmult += 0.01
		
		if $collect.stream == wunup && $collect.is_playing():
			pass
		else:
			$collect.set_stream(peece)
			$collect.play()
		if Globals.pieces % 100 == 0:
			
			$collect.set_stream(wunup)
			$collect.play()
	pass # Replace with function body.
