extends KinematicBody2D






export  var speed: = 8.0
export  var jump_strength: = 1.0
const Up = Vector2.UP
var gravity: = 1100.0
const SNAPDIR = Vector2.DOWN
var SNAPLEN = 16.0
const MAXFALLSPEED = 200 / 2
const MAXSPEED = 200
var SUPERSPEED = 400
var WAVESPEED = 600 / 2
const ATKMSPEED = 150 / 2
const ZOOMSPEED = 800
var MSPEED = 0
const floormax = deg2rad(64)
const JUMPf = 425
var yspeed = 0
var snapvec = SNAPDIR * SNAPLEN
var velocity = Vector2.ZERO
export  var deacc = 5
export  var acc = 40
var leaving = 0
var leavetimer = 20
var dashtimer = 200
export  var dashing = 0
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

var flying = false

var superdash = false

var comebacktimer = 0

var dashmeter = 0

var maxpow = 1

var nomoreflipcheck = false

var belowdetect = false
var abovedetect = false

onready var MPAura = preload("res://Maxpow.tres")
onready var Uhoh = preload("res://Damaged.tres")

var replay = []
var memory = {"L":0, "U":0, "D":0, "R":0, "Jump":0, "Attack":0, "Dash":0}
var frames = 0

var slashallowed = 1
var rotallowed = 1

var waittimer = 60 * 7

var parrytime = 20

var hittype = ""

var spvoice = preload("res://Audio/Voices/speedup.wav")


var whee = preload("res://Audio/Voices/full power.wav")

var blast = preload("res://Audio/SE/Waveboost.wav")
var Dsounder = preload("res://Audio/SE/dash.ogg")

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

var danger = preload("res://Audio/SE/Deathhit.wav")

var dam1 = preload("res://Audio/Voices/damage 1.wav")
var dam2 = preload("res://Audio/Voices/damage 2.wav")
var dam3 = preload("res://Audio/Voices/damage 3.wav")
var die = preload("res://Audio/Voices/Rded4.ogg")

var thing = preload("res://Objects/UI/Pause.tscn")

var slash = preload("res://Objects/Air_Slash.tscn")
var sgr = preload("res://Objects/Shotgunrotary.tscn")
var dust = preload("res://Subrooms/dust.tscn")
var atkfx = preload("res://Stages/Attackfx1.tscn")

var hurt = 0

var nodown = 0

var is_hit = false

#======================Command Variables cause I'll be fucking damned if I lose everything AGAIN===========================
var Odachi = false

var jump = false
var dash = false
var attack = false

var movleft = false
var movdown = false
var movup = false
var movright = false



#============================================================================================================================

func _ready():
	MSPEED = MAXSPEED
	character = get_node(".")
	$"/root/Globals".register_player(self)
	Globals.checkpX = position.x
	Globals.checkpY = position.y
	Globals.playerspriteflip = $Rspr.flip_h

func _physics_process(delta)->void :
	#print_debug(MSPEED)
	var Kleft = Input.is_action_pressed("ui_left") or Input.get_action_strength("stickleft")
	var Kleftpr = Input.is_action_just_pressed("ui_left") or Input.get_action_strength("stickleft")
	var Kright = Input.is_action_pressed("ui_right") or Input.get_action_strength("stickright")
	var Kleftrel = Input.is_action_just_released("ui_left")
	var Krightrel = Input.is_action_just_released("ui_right")
	var Kup = Input.is_action_pressed("ui_up") or Input.get_action_strength("stickup")
	var Kuppr = Input.is_action_just_pressed("ui_up") or Input.get_action_strength("stickup")
	var Kuprel = Input.is_action_just_released("ui_up") or Input.get_action_strength("stickup")
	var Kdown = Input.is_action_pressed("ui_down") or Input.get_action_strength("stickdown")
	var Kdownpr = Input.is_action_just_pressed("ui_down") or Input.get_action_strength("stickdown")
	var Kdownrel = Input.is_action_just_released("ui_down") or Input.get_action_strength("stickdown")
	var Kjump = Input.is_action_just_pressed("jump")
	var Kjumphold = Input.is_action_pressed("jump")
	var Kjumprel = Input.is_action_just_released("jump")
	var Kattack = Input.is_action_just_pressed("attack")
	var Kdash = Input.is_action_just_pressed("dash")
	var KtargR = Input.is_action_pressed("targR")
	var KtargL = Input.is_action_pressed("targL")
	var Kinteract = Input.is_action_pressed("interact")
	var Kaggro = Input.is_action_pressed("aggro")
	var Kpause = Input.is_action_pressed("pause")
	var deb1 = Input.is_action_just_pressed("hpdown")
	var deb2 = Input.is_action_just_pressed("hpup")
	var alt = Input.is_action_just_pressed("but_alt")
	var Kstrafepr = Input.is_action_just_pressed("ui_strafe")
	var Kstraferel = Input.is_action_just_released("ui_strafe")
	var Kstrafe = Input.is_action_pressed("ui_strafe")
	var Kgrab = Input.is_action_just_pressed("grab")
	var go = Input.is_action_pressed("jump")
	
	Globals.playerpos = global_position
	
	Globals.playerspriteflip = $Rspr.flip_h
	
	$Meter.value = dashmeter
	
	
	if Kpause and Globals.paused == 0 and !Globals.demoscene:
		
		get_parent().add_child(thing.instance())
	
	
	if $Rspr.animation == "idle":
		waittimer -= 1
		#print_debug(waittimer)
	
	
	if dashmeter != (60) && !flying:
		dashmeter += 1
		
	if dashmeter < 15:
		$Meter.tint_progress = Color(0.350586, 0.350586, 0.350586)
	elif dashmeter < 60:
		$Meter.tint_progress = Color(0, 0.996078, 1)
	elif dashmeter == 60:
		$Meter.tint_progress = Color(1, 0.896484, 0)
		$Meter/FULLREADY.visible = true
		superdash = true
	
	if dashmeter > (60):
		
		dashmeter = 60
	
	
	if $damagepause.is_stopped() == false:
				$Rspr.animation = "Fling"
				Globals.moveenabled = 0
				hurt = 1
				$Graze.nvm = true
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
				if $damagepause.is_stopped():
					hurt = 0
	
	
	if Globals.ded == 1:
		$Hurtbox / CollisionShape2D.disabled = true
	else :
		$Hurtbox / CollisionShape2D.disabled = false
	
	
	if !is_on_floor() && !jumping && $Rspr.animation == "dash":
		motion.y = 0
	
	
	if !is_on_floor()  && dashmeter > 0 && Kjump:
		flying = !flying
	if dashmeter <= 0 || is_on_floor() || Globals.ded:
		flying = false
	
	#print_debug(flying)
	if flying:
		jumpdash = 0
		flying()
	
	
	position.x = clamp(position.x, Globals.camera.limit_left + 20, Globals.camera.limit_right)
	
	if Kgrab and Globals.cantalk == true and Globals.moveenabled == 1:
			Globals.moveenabled = 0
			Globals.visibox = true
			if $Rspr.animation != "stop":
				$Rspr.play("stop")
	
	

	Globals.camera.rotation_degrees = $Rspr.rotation_degrees
	
	if $Rspr.animation == "Fjump" and !is_hit:
		
		if $Rspr.flip_h == true:
			$Rspr.rotation_degrees -= 8
		if $Rspr.flip_h == false:
			$Rspr.rotation_degrees += 8
	else :
		$Rspr.rotation_degrees = 0
		
	if $Rspr.animation == "airdash":
		if Kstrafe:
			if motion.x < 0 and $Rspr.flip_h == false or motion.x > 0 and $Rspr.flip_h == true:
				$Rspr.play("BDash2")
	
	
	
	SUPERSPEED = 400
	WAVESPEED = 550
	
	
	if $Rspr.flip_h == false:
		$Odachi/CollisionShape2D.scale.x = 1
	
	if $Rspr.flip_h == true:
		$Odachi/CollisionShape2D.scale.x = -1
	
	
	if Globals.combo >= 48:
		dashmeter = 60
		$Meter.tint_progress = Color(1, 0, 0)
		maxpow = 1
	
	
	if Globals.visibox == true:
		if go:
			Globals.visibox = false
	
	if Globals.incutscene == 1:
		Globals.moveenabled = 0
	
	if not Globals.incutscene:
		if Globals.ded == 0:
	
					
			
			
				
			
			
			if Globals.visibox == true:
				$GUIStuff / textbox.visible = true
			if Globals.visibox == false:
				$GUIStuff / textbox.visible = false
			
			
			var grounded
			
			
			
			if leaving == 1:
				snapvec = Vector2(0, 0)
			else :
				snapvec = SNAPDIR * SNAPLEN
			
			if $groundatk2 / CollisionShape2D.disabled == false:
				$groundatk / CollisionShape2D.disabled = true
			
			if $attack3hit / CollisionShape2D.disabled == false:
				$groundatk2 / CollisionShape2D.disabled = true
				
			if zooming == 0 or superdash and dashing == 0:
				$Zoombox / CollisionShape2D.disabled = true
			
			if atkg == 0:
				$groundatk / CollisionShape2D.disabled = true
				$groundatk2 / CollisionShape2D.disabled = true
				$attack3hit / CollisionShape2D.disabled = true
			
			if atkg == 2:
				$groundatk / CollisionShape2D.disabled = true
				$groundatk2 / CollisionShape2D.disabled = true
				
			if atkg == 3:
				$groundatk / CollisionShape2D.disabled = true
				$attack3hit / CollisionShape2D.disabled = true
			
			if atka == 0 or $Rspr.animation == "idle" or $Rspr.animation == "Stance" or $Rspr.animation == "run" or $Rspr.animation == "dash" or $Rspr.animation == "BDash":
				$airatk / CollisionShape2D.disabled = true
			
			if  $Rspr.animation == "OdachiFlash":
				$Odachi/CollisionShape2D.disabled = false
			else:
				$Odachi/CollisionShape2D.disabled = true
			
			
			
				
				
				
				
				
			if dashing == 1:
				
				if wavedashing and is_on_floor():
					
					MSPEED = WAVESPEED
				else :
					if MSPEED <= SUPERSPEED:
						MSPEED = SUPERSPEED
					elif MSPEED > SUPERSPEED && MSPEED < WAVESPEED:
						MSPEED = WAVESPEED
					else:
						 MSPEED = MSPEED
				if $Rspr.animation == "airdash" or $Rspr.animation == "BDash2":
					motion.y = 0
					
				
				if superdash:
					grooveAppend("SuperDash")
					$Zoombox / CollisionShape2D.disabled = false
				
				if Kgrab:
					Odachi = true
					OdachiFlash()
				
				if atkg:
					grooveAppend("dashCancel")
				
				if atkg or superdash:
					var dashfx = preload("res://Stages/dashfx.tscn").instance()
					
#					get_parent().add_child(dashfx)
#					dashfx.position = position
#					dashfx.flip_h = $Rspr.flip_h
					$SPARKS.visible = true
					
					
							
						
					if not atkdashv:
						
						
						
						$Blast.play()
						atkdashv = 1
						
				
				if is_on_floor() and $Rspr.animation != "attackair" and Globals.moveenabled == 1:
					if facedir == 1:
						
						motion.x = MSPEED
						
					if facedir == - 1:
						motion.x = - MSPEED
				elif (Kleft and Kup and Globals.moveenabled == 1) || (movleft && movup):
					motion.x = - MSPEED
					motion.y = - MSPEED
					if $Rspr.animation != "OdachiFlash":
						$Rspr.play("ADUpDiag")
				elif Kleft and Kdown and Globals.moveenabled == 1 || (movleft && movdown):
					motion.x = - MSPEED
					if $Rspr.animation != "OdachiFlash":
						$Rspr.play("ADDownDiag")
					if !nodown:
						motion.y = MSPEED
					if is_on_floor() && Globals.type == "Advanced":
						wavedashing = 1
				elif Kleft || movleft:
					if $Rspr.animation != "OdachiFlash":
						$Rspr.play("ADSide")
					motion.x = - MSPEED
					if is_on_floor() && Globals.type == "Advanced":
						wavedashing = 1
				elif Kright and  Kup and Globals.moveenabled == 1 || (movright && movup): 
					if $Rspr.animation != "OdachiFlash":
						$Rspr.play("ADUpDiag")
					motion.x = MSPEED
					motion.y = - MSPEED
					
				elif Kright and Kdown and Globals.moveenabled == 1 || (movright && movdown):
					motion.x = MSPEED
					if $Rspr.animation != "OdachiFlash":
						$Rspr.play("ADDownDiag")
					if !nodown:
						motion.y = MSPEED
					if is_on_floor() && Globals.type == "Advanced":
						wavedashing = 1
				elif Kright and Globals.moveenabled == 1 || (movright):
					if not jumpdash:
						motion.x = MSPEED
					if $Rspr.animation != "OdachiFlash":
						$Rspr.play("ADSide")
					if is_on_floor() && Globals.type == "Advanced":
						wavedashing = 1
				elif Kup and Globals.moveenabled == 1 || (movup):
					motion.y = - MSPEED
					if $Rspr.animation != "OdachiFlash":
						$Rspr.play("ADUp")
				elif Kdown and Globals.moveenabled == 1 || (movdown):
					
					if !nodown:
						motion.y = MSPEED
						if $Rspr.animation != "OdachiFlash":
							$Rspr.play("ADDown")
					if is_on_floor() && Globals.type == "Advanced":
						wavedashing = 1
						
						
				
			else :
				wavedashing = 0
				atkdashv = 0
#				if Krightrel || Kleftrel:
#					MSPEED = MAXSPEED
				if !flying:
					motion.y += gravity * delta
				if Kjumprel and motion.y < - 400 and stopit == 0:
					motion.y = - 400.0
					stopit = 1
					
			if jumpdash || dashing:
				var gospeed = abs(motion.x)
				
				if motion.x > WAVESPEED * 2 || motion.x < -WAVESPEED * 2:
					#MSPEED = gospeed
					pass
				else:
					if MSPEED <= SUPERSPEED:
						MSPEED = SUPERSPEED
					elif MSPEED > SUPERSPEED && MSPEED <= WAVESPEED:
						MSPEED = WAVESPEED
					if Globals.camera.zoom.x < 1.3 && Globals.zoomallowed:
						Globals.camera.zoom.x += 0.02
						Globals.camera.zoom.y += 0.02
						comebacktimer = 60
			else:
				if comebacktimer <= 0:
					if Globals.camera.zoom.x > 1 && Globals.zoomallowed:
						Globals.camera.zoom.x -= 0.02
						Globals.camera.zoom.y -= 0.02
				else: comebacktimer -= 1
				
			
			
	
	
	
	
	
	
	
	
			if zooming:
				Globals.moveenabled = 0
				
				MSPEED = ZOOMSPEED
				
				
				$Zoombox / CollisionShape2D.disabled = false
				if zoomdir == 0:
					motion.y = 0
					motion.x = MSPEED
					$Rspr.play("waveburst")
				if zoomdir == 1:
					leaving = 1
					motion.y = -ZOOMSPEED
					motion.x = 0
					$Rspr.play("Fjump")
			
			
			
			if MSPEED > 0:
				motion.x = clamp(motion.x, - MSPEED, MSPEED)
			
			grounded = is_on_floor()
			
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
			
			
			if Kright and !is_hit and Globals.moveenabled == 1 || (movright):
				if is_on_floor() and not atkg and not dashing:
					MSPEED = MAXSPEED
					if Kstrafe and $Rspr.flip_h == false:
						$Rspr.play("StrafeF")
					elif Kstrafe and $Rspr.flip_h == true:
						$Rspr.play("StrafeB")
					else :
						$Rspr.play("run")
					
				if not Kstrafe:
					get_node("Rspr").flip_h = false
				get_node("groundatk").set_scale(Vector2(1, 1))
				get_node("groundatk2").set_scale(Vector2(1, 1))
				get_node("attack3hit").set_scale(Vector2(1, 1))
				if not atkg or dashing or jumpdash:
					#print_debug(acc)
					motion.x += acc
					pass
				else :
						
						motion.x = 0
				facedir = 1
				
			elif Kleft and  !is_hit and Globals.moveenabled == 1 || (movleft):
				
				if is_on_floor() and not atkg and not dashing:
					MSPEED = MAXSPEED
					if Kstrafe and $Rspr.flip_h == false:
						$Rspr.play("StrafeB")
					elif Kstrafe and $Rspr.flip_h == true:
						$Rspr.play("StrafeF")
					else :
						$Rspr.play("run")
					
				if not Kstrafe:
					get_node("Rspr").flip_h = true
				get_node("groundatk").set_scale(Vector2( - 1, 1))
				get_node("groundatk2").set_scale(Vector2( - 1, 1))
				get_node("attack3hit").set_scale(Vector2( - 1, 1))
				if not atkg or dashing or jumpdash:
					
					motion.x -= acc
				else :
						
						motion.x = 0
				facedir = - 1
			
			else :
				if is_on_floor():
					if $Rspr.animation == "run" or $Rspr.animation == "fall" or $Rspr.animation == "BJump" or $Rspr.animation == "Fjump" or $Rspr.animation == "StrafeB" or $Rspr.animation == "StrafeF" or $Rspr.animation == "Fly":
						atkg = 0
						if Input.is_action_pressed("ui_strafe"):
							$Rspr.play("Stance")
						else :
							$Rspr.play("idle")
							waittimer -= 1
						
					stopit = 0
					motion.x = lerp(motion.x, 0, 0.1)
				
					
					
					
					
					
					
				if Kstrafepr and $Rspr.animation == "idle" and Globals.moveenabled == 1:
					if is_on_floor():
						$Rspr.play("Stance")
				
				
				if Kstraferel and $Rspr.animation == "Stance" and Globals.moveenabled == 1:
					if is_on_floor():
						$Rspr.play("idle")
				
					
			if Kjump and Globals.moveenabled == 1 || (jump):
				jumpoff()
				if is_on_floor():
					$Jump.play(0.0)
					$Rspr.scale.x = 0.2
					$Rspr.scale.y = 2
					atkg = 0
					leaving = 1
					jumping = true
					if dashing:
						nodown = 1
						grooveAppend("VecAir")
						jumpdash = 1
						
					motion.y /= 4
					motion.y -=  (JUMPf)
					
				
					
					
					
					$snapoff.start()
				
					
			if (Kdash and  dashmeter >= 15 and !is_hit and Globals.moveenabled == 1) || (dash):
				
				dashoff()
				if dashes > 0 || flying:
					dashing = 1
					nodown = 0
					$SPARKS.frame = 0
					
					
					$Hurtbox / dodge_window.start()
					dashtimer = 800
					if !flying:
						dashmeter = 0
					if not is_on_floor():
						atka = 0
						if Kstrafe:
							if motion.x < 0 and $Rspr.flip_h == false or motion.x > 0 and $Rspr.flip_h == true:
								$Rspr.play("BDash2")
								grooveAppend("BackDashAir")
								print_debug(Globals.grooveList)
							else :
								$Rspr.play("airdash")
						else :
							$Rspr.play("airdash")
							grooveAppend("AirDash")
							print_debug(Globals.grooveList)
						if Engine.time_scale == 1.0:
							dashes -= 1
					else :
						var dustinst = dust.instance()
						get_parent().add_child(dustinst)
						dustinst.global_position = position
						dustinst.flip_h = $Rspr.flip_h
						if dustinst.flip_h == false:
							dustinst.offset.x = - 33
						if dustinst.flip_h == true:
							dustinst.offset.x = 33
						
						$dsound.set_stream(Dsounder)
						var pitch_scale = [0.8, 0.9, 1, 1.1, 1.2]
						randomize()
						$dsound.pitch_scale = pitch_scale[randi() % pitch_scale.size()]
						$dsound.play()
			
			
			
			
			if is_on_floor():
				if not dashing:
					jumpdash = 0
					MSPEED = MAXSPEED
				if not leaving:
					jumping = false
					
				nomoreflipcheck = false
				dashes = 2
				slashallowed = 1
				rotallowed = 1
				
				
					
				var stream_array = [wav1, wav2, wav3, wav4, null, ]
				randomize()
				var play = stream_array[randi() % stream_array.size()]
				
				if ($Rspr.animation == "airdash" || $Rspr.animation == "ADDown" || $Rspr.animation == "ADDownDiag") && Globals.type == "Advanced":
					$Voices / dodgeVoices.set_stream(play)
					$Voices / dodgeVoices.play()
					$Blast.play()
					dashtimer = 800
					wavedashing = 1
					
				
				if $Rspr.animation != "attackg_a" and not dashing and Globals.moveenabled == 1:
						$groundatk / CollisionShape2D.disabled = true
				if $Rspr.animation != "attackg_b" and not dashing and Globals.moveenabled == 1:
						$groundatk2 / CollisionShape2D.disabled = true
				if $Rspr.animation != "attackg_c" and not dashing and Globals.moveenabled == 1:
						$attack3hit / CollisionShape2D.disabled = true
						
				
					
					
				var audio_stream_array = [atkv1, atkv2, atkv3, atkv4, null, null]
				randomize()
				var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
						
				if atkpts == 3 and (Kattack and not leaving and Globals.moveenabled == 1) or (attack and not leaving):
					attack = false
					$atktimer.start()
					$atkwait.start()
					atkg = 1
					atka = 0
					
			
					$Voices / dodgeVoices.set_stream(clip_to_play)
					$Voices / dodgeVoices.play()
						
					MSPEED = ATKMSPEED
					
					
					
					
					$Rspr.animation != "run"
					grooveAppend("GAtk1")
					print_debug(Globals.grooveList)
					$Rspr.play("attackg_a")
					
					var atkfxinst = atkfx.instance()
					atkfxinst.position.x = position.x
					atkfxinst.position.y = position.y


					atkfxinst.flip_h = $Rspr.flip_h
					get_parent().add_child(atkfxinst)
					atkpts -= 1
					dashing = 0
					
					$groundatk / CollisionShape2D.disabled = true
					
				if is_on_floor() and not atkg and (Kleftrel) and Globals.moveenabled == 1 or is_on_floor() and not atkg and (Krightrel) and Globals.moveenabled == 1:
					$Rspr.play("stop")
					waittimer = 60 * 7
					
				elif (atkpts == 2 and (Kattack) and not leaving and $atkwait.is_stopped() and Globals.moveenabled == 1) or (atkpts == 2 and (attack) and not leaving and $atkwait.is_stopped()):
					attack = false
					$groundatk / CollisionShape2D.disabled = true
					$atktimer.start()
					$atkwait2.start()
					atkg = 3
					atka = 0
					MSPEED = ATKMSPEED
					$Rspr.animation != "run"
					grooveAppend("GAtk2")
					
					$Rspr.play("attackg_b")
					dashing = 0
				
				
					$Voices / dodgeVoices.set_stream(clip_to_play)
					$Voices / dodgeVoices.play()
						
					atkpts -= 1
				elif (atkpts == 1 and (Kattack) and not leaving and $killhitbox2.is_stopped() and (Globals.moveenabled == 1)) or (atkpts == 1 and (attack) and not leaving and $killhitbox2.is_stopped()):
					attack = false
					$attack3hit / CollisionShape2D.disabled = true
					$atktimer.start()
					atkg = 2
					atka = 0
					MSPEED = ATKMSPEED
					$groundatk / CollisionShape2D.disabled = true
					$attack3hit / CollisionShape2D.disabled = false
					$Rspr.animation != "run"
					
					$Voices / dodgeVoices.set_stream(clip_to_play)
					$Voices / dodgeVoices.play()
					grooveAppend("GAtk3")
					
					$Rspr.play("attackg_c")
					atkpts -= 1
				elif dashing and motion.x != 0 :#and Globals.moveenabled == 1
					if $Rspr.animation != "attackair":
						atka = 0
						if wavedashing:
							grooveAppend("Waveburst")
							$Rspr.play("waveburst")
							if Globals.atkmult >= 3:
								$Camera2D / CanvasLayer2 / spline.visible = true
						else :
							if Kstrafe:
								if motion.x < 0 and $Rspr.flip_h == false or motion.x > 0 and $Rspr.flip_h == true:
									$Rspr.play("BDash")
									grooveAppend("BackDash")
								else :
									$Rspr.play("dash")
									grooveAppend("Dash")
							else :
								$Rspr.play("dash")
								grooveAppend("Dash")
							if Globals.atkmult >= 3:
								$Camera2D / CanvasLayer2 / spline.visible = true
						
			else :
					
					if not is_on_floor() || flying:
						
						if (Kgrab and rotallowed == 1 and atka == 1):
								print_debug("FUCK")
								grooveAppend("SGRot")
								get_parent().add_child(sgr.instance())
								rotallowed = 0
						
						if (Kattack || attack):
							attack = false
							atkg = 0
							if slashallowed == 1 and atka == 1:
								get_parent().add_child(slash.instance())
								grooveAppend("DoubleSlice")
								slashallowed = 0
								
								
							
							atka = 1
							
							$airatk / CollisionShape2D.disabled = false
							$atktimer.start()
							
							
							
							
							
							
							
					
					
							var audio_stream_array = [atkv1, atkv2, atkv3, atkv4, null, null]
							randomize()
							var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
							if $Rspr.animation != "attackair":
								$Voices / dodgeVoices.set_stream(clip_to_play)
								$Voices / dodgeVoices.play()
								grooveAppend("NeonSpinner")
								$Rspr.play("attackair")
			
			
			
			
			
			if $snapoff.is_stopped():
				leaving = 0
				
				
			if dashtimer > 0:
				dashtimer -= (1 / delta * Engine.time_scale)
				if dashtimer <= 0:
					$SPARKS.visible = false
					leavetimer = 0
					atkg = 0
					superdash = 0
					dashing = 0
					if !wavedashing:
						MSPEED = MAXSPEED
					
					
					
			
			motion.y = move_and_slide_with_snap(motion, snapvec, Up, true, 6, floormax, false).y
				
			if not is_on_floor():
				
				if motion.y > 0 and not dashing and $Rspr.animation != "attackair" && $Rspr.animation != "OdachiFlash":
					if ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == false && motion.x < 1 || ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == true && motion.x > 1 && $damagepause.is_stopped():
						if $Rspr.animation != "BJump":
							grooveAppend("Backflip")
							$Rspr.play("BJump")
					elif ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == true && motion.x < 1 || ((Input.is_action_pressed("ui_strafe")) || jumpdash) && $Rspr.flip_h == false && motion.x > 1 && $damagepause.is_stopped():
						if $Rspr.animation != "Fjump":
							grooveAppend("Frontflip")
							$Rspr.play("Fjump")
					else:
						if $Rspr.animation != "fall" && !flying:
							$Rspr.play("fall")
				elif motion.y < 0 and not dashing and  $Rspr.animation != "attackair" && $Rspr.animation != "OdachiFlash":
					if ((Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == false && motion.x < 1 || (Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == true && motion.x > 1) && $damagepause.is_stopped():
						if $Rspr.animation != "BJump":
							grooveAppend("Backflip")
							if nomoreflipcheck == false:
								Globals.stuntTimer = 60 * 1.5
								Globals.stuntList.append("backFlip")
								nomoreflipcheck = true
							$Rspr.play("BJump")
					elif ((Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == true && motion.x < 1 || (Input.is_action_pressed("ui_strafe")) && $Rspr.flip_h == false && motion.x > 1) && $damagepause.is_stopped():
						if $Rspr.animation != "Fjump":
							grooveAppend("Frontflip")
							if nomoreflipcheck == false:
								Globals.stuntTimer = 60 * 1.5
								Globals.stuntList.append("frontFlip")
								nomoreflipcheck = true
							$Rspr.play("Fjump")
					elif $Rspr.animation != "Fjump" && $Rspr.animation != "Bjump" && $Rspr.animation != "OdachiFlash" && $damagepause.is_stopped() == true:
						if $Rspr.animation != "jump" && !flying:
							grooveAppend("JumpReg")
							$Rspr.play("jump")
			
			
			
			
			if Globals.hpcount == 0:
				Globals.groovePoints = 0
				Globals.groovePoints = 0
				Globals.grooveList = [null, null, null, null, null]
				Globals.ded = 1
				$Deathwait.start()
			
			
			
		
		
		
		
		if position.y > Globals.camera.limit_bottom + 24:
			Globals.hpcount = 0
		
	if not is_on_floor() and jumping == false and dashing:
		jumpdash = 1
		
		
	
	if is_hit && parrytime > 0:
		motion.x = 0
		motion.y = 0
		$Rspr.playing = false
		parrytime -= 1
	
	if is_hit && parrytime > 0 && dashmeter >= 15:
		if Input.is_action_just_pressed("dash"):
			grooveAppend("Parry")
			$Rspr/Shaders.play("Parry flash")
			$dodge.set_stream(dodges)
			$dodge.play()
			$Hurtbox/safe_frames.start()
			dashmeter -= 15
			is_hit = false
			$Rspr.playing = true
	elif is_hit && parrytime <= 0:
		Globals.groovePoints -= Globals.groovePoints / 2
		#Globals.grooveTimer = 0
		flying = false
		damagehandle(hittype)
		is_hit = false
		$Rspr.playing = true
	

func attack():
	attack = true

func dash():
	dash = true

func jump():
	jump = true

func movup():
	movup = true

func movdown():
	movdown = true

func movleft():
	movleft = true

func movright():
	movright = true

func dashoff():
	dash = false

func jumpoff():
	jump = false

func movupoff():
	movup = false

func movdownoff():
	movdown = false

func movleftoff():
	movleft = false

func movrightoff():
	movright = false
	

func flying():
	
	var Kleft = Input.is_action_pressed("ui_left") or Input.get_action_strength("stickleft")
	var Kleftpr = Input.is_action_just_pressed("ui_left") or Input.get_action_strength("stickleft")
	var Kright = Input.is_action_pressed("ui_right") or Input.get_action_strength("stickright")
	var Kleftrel = Input.is_action_just_released("ui_left")
	var Krightrel = Input.is_action_just_released("ui_right")
	var Kup = Input.is_action_pressed("ui_up") or Input.get_action_strength("stickup")
	var Kuppr = Input.is_action_just_pressed("ui_up") or Input.get_action_strength("stickup")
	var Kuprel = Input.is_action_just_released("ui_up") or Input.get_action_strength("stickup")
	var Kdown = Input.is_action_pressed("ui_down") or Input.get_action_strength("stickdown")
	var Kdownpr = Input.is_action_just_pressed("ui_down") or Input.get_action_strength("stickdown")
	var Kdownrel = Input.is_action_just_released("ui_down") or Input.get_action_strength("stickdown")
	var Kjump = Input.is_action_just_pressed("jump")
	var Kjumphold = Input.is_action_pressed("jump")
	var Kjumprel = Input.is_action_just_released("jump")
	var Kattack = Input.is_action_just_pressed("attack")
	var Kdash = Input.is_action_just_pressed("dash")
	var KtargR = Input.is_action_pressed("targR")
	var KtargL = Input.is_action_pressed("targL")
	var Kinteract = Input.is_action_pressed("interact")
	var Kaggro = Input.is_action_pressed("aggro")
	var Kpause = Input.is_action_pressed("pause")
	var deb1 = Input.is_action_just_pressed("hpdown")
	var deb2 = Input.is_action_just_pressed("hpup")
	var alt = Input.is_action_just_pressed("but_alt")
	var Kstrafepr = Input.is_action_just_pressed("ui_strafe")
	var Kstraferel = Input.is_action_just_released("ui_strafe")
	var Kstrafe = Input.is_action_pressed("ui_strafe")
	var Kgrab = Input.is_action_just_pressed("grab")
	var go = Input.is_action_pressed("jump")
	
	if $Rspr.animation != "attackair":
		$Rspr.play("Fly")
	
	
	dashmeter -= 0.5
	
	if !dashing:
		MSPEED = MAXSPEED
	if (Kleft and Kup and Globals.moveenabled == 1) || (movleft && movup):
		motion.x = - MSPEED
		motion.y = - MSPEED
	elif Kleft and Kdown and Globals.moveenabled == 1 || (movleft && movdown):
		motion.x = - MSPEED
		motion.y = MSPEED

	elif Kleft || movleft:

		motion.x = - MSPEED
		motion.y = 0

	elif Kright and  Kup and Globals.moveenabled == 1 || (movright && movup): 
		motion.x = MSPEED
		motion.y = - MSPEED
		
	elif Kright and Kdown and Globals.moveenabled == 1 || (movright && movdown):
		motion.x = MSPEED
		motion.y = MSPEED
	elif Kright and Globals.moveenabled == 1 || (movright):
			motion.x = MSPEED
			motion.y = 0
	elif Kup and Globals.moveenabled == 1 || (movup):
		motion.y = - MSPEED
	elif Kdown and Globals.moveenabled == 1 || (movdown):
		motion.y = MSPEED
	
	else:
		motion.x = 0
		motion.y = 0

func OdachiFlash():
	grooveAppend("OdFlash")
	print_debug(Globals.grooveList)
	$Rspr.frame = 0
	
	if dashing && !is_on_floor():
		$Rspr.play("OdachiFlash")
	

func _on_Rspr_animation_finished():
	if $Rspr.animation == "idle" && waittimer <= 0:
		$Rspr.frame = 0
		$Rspr.play("WaitA")
		
	elif $Rspr.animation == "WaitA":
		$Rspr.frame = 0
		$Rspr.play("WaitB")
	
	if $Rspr.animation == "OdachiFlash":
		Odachi = false
		$Rspr.animation = "fall"
	
	if $Rspr.animation == "attackg_a" or $Rspr.animation == "dash" and dashing == 0 or $Rspr.animation == "BDash" and dashing == 0 or $Rspr.animation == "waveburst" and zooming == 0:
		atkg = 0
		$groundatk / CollisionShape2D.disabled = true
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else :
			$Rspr.play("idle")
	elif $Rspr.animation == "attackg_b":
		atkg = 0
		$groundatk2 / CollisionShape2D.disabled = true
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else :
			$Rspr.play("idle")
			$Rspr.play("idle")
	elif $Rspr.animation == "attackg_c":
		atkg = 0
		$attack3hit / CollisionShape2D.disabled = true
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else :
			$Rspr.play("idle")
		atkpts = 3
	elif $Rspr.animation == "attackair":
		atka = 0
		$airatk / CollisionShape2D.disabled = true
		$Rspr.play("idle")
	elif $Rspr.animation == "airdash":
		atkg = 0
		$Rspr.play("idle")
	elif $Rspr.animation == "stop":
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else :
			$Rspr.play("idle")
	elif $Rspr.animation == "damage":
		if Input.is_action_pressed("ui_strafe"):
			$Rspr.play("Stance")
		else :
			$Rspr.play("idle")
		Globals.moveenabled = 1


var shakeamount = 0
func camshake():
	var intensity = 0.5
	var duration = 0.2
	
	
	



func _on_atktimer_timeout():
	atkpts = 3


func _on_gtimer_timeout():
	if dashing or zooming or jumpdash:
		
		var this_ghost = preload("res://Stages/ghost.tscn").instance()
		
		get_parent().add_child(this_ghost)
		












		if wavedashing:
			this_ghost = preload("res://Stages/wbghost.tscn").instance()
			get_parent().add_child(this_ghost)
			this_ghost.mode = 1
		else :
			
			this_ghost.mode = 0
		this_ghost.position = position
		this_ghost.scale.x = 1
		this_ghost.scale.y = 1
		this_ghost.rotation_degrees = $Rspr.rotation_degrees
		this_ghost.texture = $Rspr.frames.get_frame($Rspr.animation, $Rspr.frame)
		this_ghost.flip_h = $Rspr.flip_h
		
		
		
	

func _on_atkwait_timeout():
	$groundatk / CollisionShape2D.disabled = false


func _on_atkwait2_timeout():
	$groundatk2 / CollisionShape2D.disabled = false
	
	$killhitbox2.start()


func _on_killhitbox2_timeout():
	if not dashing:
		$groundatk2 / CollisionShape2D.disabled = true

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield (get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0



func _on_Hurtbox_area_entered(area):
	
	
	if area.is_in_group("springhurt"):
		dashing = 0
		motion = - motion
		
		
	
	
	if area.is_in_group("Zoombox"):
		if dashing or zooming or jumpdash:
			
			
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
			$StageMusic / musichandler.play("fadeout")
		else :
			$StageMusic / musichandler.play("fadein")
	
	
	
	if area.is_in_group("enemproject") or area.is_in_group("TouchHurt") or area.is_in_group("bighurt"):
		
		var audio_stream_array = [dam1, dam2, dam3]
		randomize()
		var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
		if not dashing and not zooming and not jumpdash and not is_hit and Globals.canthurt == 0 or area.is_in_group("undodgeable"):
			if $damagepause.is_stopped():
				if $Hurtbox / safe_frames.is_stopped():
					if area.is_in_group("bighurt"):
						motion.x = 0
						motion.y = 0
						dashing = 0
						parrytime = 6
						hittype = "bighit"
						is_hit = true
						var hs = preload("res://Subrooms/hurtspark.tscn")
						var ma = hs.instance()
						ma.position = global_position
						get_parent().add_child(ma)
						$dodge.set_stream(danger)
						$dodge.play()
						
					if area.is_in_group("TouchHurt") and not atka or area.is_in_group("enemproject"):
						motion.x = 0
						motion.y = 0
						dashing = 0
						parrytime = 10
						hittype = "touchhit"
						is_hit = true
						var hs = preload("res://Subrooms/hurtspark.tscn")
						var ma = hs.instance()
						ma.position = global_position
						get_parent().add_child(ma)
						$dodge.set_stream(danger)
						$dodge.play()
					
							
						
					
					
					
		
		if (dashing || Odachi) && !area.is_in_group("undodgeable"):
			if $Hurtbox / dodge_window.is_stopped() == false:
				
			
				audio_stream_array = [dodgev1, dodgev2, dodgev3, dodgev4, dodgev5, null, null, ]
				randomize()
				clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
				$dodge.set_stream(dodges)
				$dodge.play()
				$Voices / dodgeVoices.set_stream(clip_to_play)
				$Voices / dodgeVoices.play()
				
				Globals.score += 100
				Globals.combotimer += 60 * 10
				Globals.linktimer += 60 * 10
				if Globals.combotimer > (60 * 10):
					Globals.combotimer = 60 * 10
				if Globals.linktimer > (60 * 10):
					Globals.linktimer = 60 * 10
				
				Globals.dodged = true

			
			
			
				
			


func _on_damagepause_timeout():
	Globals.moveenabled = 1
	hurt = 0
	$Hurtbox/safe_frames.start()
	$Graze.nvm = true


func _on_Deathwait_timeout():
	
	if Globals.lives > 0:
		position.x = Globals.checkpX
		position.y = Globals.checkpY
		
		
		
		$Rspr.play("idle")
		
		
		Globals.lives -= 1
		Globals.atkmult = 0
		Globals.combo = 0
		Globals.link = 0
		Globals.hpcount = 5
		Globals.ded = 0

	


func _on_nowFade_timeout():
	$Camera2D / CanvasLayer2 / GameoverSpr / GOAnimate.play("Gameoverend")


func _on_GOAnimate_animation_finished(anim_name):
	if anim_name == "Gameoverend":
		Globals.music.stop()
		Sys.load_scene(Globals.cur_scene,"res://Stages/Titlescreen.tscn")
		Globals.cur_scene.queue_free()
		get_tree().paused = false
	



func damagehandle(var type):
	
	match(type):
		"bighit":
			var hs = preload("res://Subrooms/hurtspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			Globals.hpcount -= 3
			var damage = preload("res://Subrooms/DAMAGE PLAYER.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(3)
			get_parent().add_child(damobj)
			Globals.combo = 0
		"touchhit":
			var hs = preload("res://Subrooms/hurtspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			Globals.hpcount -= 1
			var damage = preload("res://Subrooms/DAMAGE PLAYER.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1)
			get_parent().add_child(damobj)
			Globals.pieces -= 5
			Globals.link = 0
			Globals.combo = 0
			Globals.atkmult -= (1)
	
	var audio_stream_array = [dam1, dam2, dam3]
	randomize()
	var clip_to_play = audio_stream_array[randi() % audio_stream_array.size()]
	
	if Globals.pieces < 0:
		Globals.pieces = 0
	if Globals.atkmult < 0.01:
		Globals.atkmult = 0.01
	if Globals.hpcount <= 0:
		$otvoice.stop()
		$Rspr.play("die")
		$Graze.nvm = true
		$otvoice.set_stream(die)
		flying = 0
		dashing = 0
		zooming = 0
		jumpdash = 0
		motion.x = 0
		motion.y = 0
		Globals.groovePoints = 0
		Globals.groovePoints = 0
		Globals.grooveList = [null, null, null, null, null]
		Globals.ded = 1
		$otvoice.volume_db = 3
		$otvoice.play()
		$Deathwait.start()
	else :
		Globals.moveenabled = 0
		hurt = 1
		$scarfpart.gravity = motion / 4
		$scarfpart.emitting = true
		$damagepause.start()
		$Rspr.play("damage")
		$Voices/dodgeVoices.set_stream(clip_to_play)
		$Voices/dodgeVoices.play()
		atkg = 0





func grooveAppend(var string):
	var instancecount = Globals.grooveList.count(string)
	
	match(instancecount):
		0:
			Globals.groovePoints += Globals.grooveWorth
			Globals.grooveTimer = Globals.grooveTimerMax
			Globals.grooveList.append(string)
			Globals.grooveList.pop_front()




func _on_zoomtime_timeout():
	zooming = 0
	Globals.moveenabled = 1
	


func _on_otvoice_finished():
	pass


func _on_dashatkvoice_finished():
	if Globals.link >= 30:
		speedup = 1
		
	


func _on_Collect_area_entered(area):
	
	if area.is_in_group("pieceobject"):
		Globals.combotimer += 60 * 10
		
		if $collect.stream == wunup and $collect.is_playing():
			pass
		else :
			$collect.set_stream(peece)
			$collect.play()
		if Globals.pieces == 100 or Globals.pieces == 250 or Globals.pieces == 500 or Globals.pieces == 600:
			
			$collect.set_stream(wunup)
			$collect.play()
	
	if area.is_in_group("lifeobject"):
		$collect.set_stream(wunup)
		$collect.play()
	pass


func _on_safe_frames_timeout():
	$Graze.nvm = false
	pass # Replace with function body.


func _on_FULLREADY_animation_finished():
	$Meter/FULLREADY.visible = false
	pass # Replace with function body.


func _on_AboveDetect_area_entered(area):
	if area.is_in_group("enemproject"):
		abovedetect = true
	pass # Replace with function body.


func _on_AboveDetect_area_exited(area):
	if !area.is_in_group("enemproject"):
		abovedetect = false
		
	pass # Replace with function body.


func _on_BelowDetect_area_entered(area):
	if area.is_in_group("enemproject"):
		print_debug("HELLO?! FAGGOT?!")
		belowdetect = true
		Globals.stuntTimer = 60 * 1.5
		var bulletcheck = Globals.stuntList.count("OverBullet")
		if bulletcheck == 0 && !jumpdash && !area.is_in_group("Odachi"):
			Globals.stuntList.append("OverBullet")



func _on_BelowDetect_area_exited(area):
	if !area.is_in_group("enemproject"):
		belowdetect = false



func snapoffexternal():
	$snapoff.start()
