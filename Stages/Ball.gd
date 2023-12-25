extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 50
var active = false
var BSpeed = 200
var Shootsound = preload("res://Audio/SE/SHuskShoot.wav")
var activate = preload("res://Audio/SE/Detected.wav")
var projallowed = 1

var dielol = 0
onready var hpbar = $EnemHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if hp <= 0:
		if dielol == 0:
			frameFreeze(0.05, 0.9)
			dielol = 1
		
		
		
		
#	hpbar.value = hp
#	hpbar.max_value = 3
#	hpbar.min_value = 0
	
	#$hptween.interpolate_property(hpbar,"hp",hpbar.value, hp,0.4,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
#
#	if $Stickhusk.animation == "shoot":
#		if $Stickhusk.frame == 2:
#
#			if projallowed == 1:
#				var BulletA = preload("res://Subrooms/Basic Proj.tscn").instance()
#				var BulletB = preload("res://Subrooms/Basic Proj.tscn").instance()
#				var BulletC = preload("res://Subrooms/Basic Proj.tscn").instance()
#
#
#
#				$Stickhusk/Sounds.stream = Shootsound
#				$Stickhusk/Sounds.play()
#				BulletA.mode = 1
#				BulletB.mode = 2
#				BulletC.mode = 3
#
#				get_parent().add_child(BulletA)
#
#				get_parent().add_child(BulletB)
#
#				get_parent().add_child(BulletC)
#				if $Stickhusk.flip_h == false:
#					BulletA.position.x = position.x - 96
#					BulletA.position.y = position.y
#					BulletB.position.x = position.x - 96
#					BulletB.position.y = position.y
#					BulletC.position.x = position.x - 96
#					BulletC.position.y = position.y
#
#					BulletA.scale.x = -1
#					BulletB.scale.x = -1
#					BulletC.scale.x = -1
#
#
#				if $Stickhusk.flip_h == true:
#					BulletA.position.x = position.x + 96
#					BulletA.position.y = position.y
#					BulletB.position.x = position.x + 96
#					BulletB.position.y = position.y
#					BulletC.position.x = position.x + 96
#					BulletC.position.y = position.y
#					BulletA.scale.x = 1
#					BulletB.scale.x = 1
#					BulletC.scale.x = 1
#
#
#
#
#
#				projallowed = 0
#
#
#	pass

func frameFreeze(timeScale, duration):
	
	var DS = preload("res://Subrooms/Dspark.tscn").instance()
	DS.position = position
	get_parent().add_child(DS)
	Globals.canthurt = 1
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	
	
	Engine.time_scale = 1.0
	Globals.canthurt = 0
	var diesound = preload("res://Audio/SE/Enemdie.wav")
	#Globals.atkmult += (.3)
	Globals.didakill = 1
	queue_free()
#	$Stickhusk/Sounds.stream = diesound
#
#	$Stickhusk/Sounds.play()
#	$Stickhusk.play("die")



func frameFreezenonlethal(timeScale, duration):
	
	Globals.canthurt = 1
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
	Globals.canthurt = 0






	

func _on_Area2D_area_entered(area):
	

	pass

func _on_multihurt_timeout():
	$multihurtrepeat.stop()
	


func _on_Area2D_area_exited(area):
	$multihurt.stop()


func _on_multihurtrepeat_timeout():
	if !$multihurt.is_stopped():
		$multihurtrepeat.start()
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()
		hp -= 0.3 + Globals.atkmult



#func _on_HorizDetect_area_entered(area):
#	if area.is_in_group("hurtbox"):
#		$Stickhusk.flip_h = false
#		if !active && hp > 0:
#			$Stickhusk/Sounds.stream = activate
#			$Stickhusk/Sounds.play()
#			$Stickhusk.animation = "shoot"
#			active = true
#
#	pass # Replace with function body.
#
#
#func _on_HorizDetectright_area_entered(area):
#	if area.is_in_group("hurtbox"):
#		$Stickhusk.flip_h = true
#		if !active && hp > 0:
#			$Stickhusk/Sounds.stream = activate
#			$Stickhusk/Sounds.play()
#			$Stickhusk.animation = "shoot"
#			active = true
#	pass # Replace with function body.
#
#
#func _on_Stickhusk_animation_finished():
#	if $Stickhusk.animation == "shoot":
#		projallowed = 1
#
#	if $Stickhusk.animation == "die":
#		queue_free()


func _on_Ball_area_entered(area):
	if area.is_in_group("hit1"):
		Globals.combotimer = 60 * 10
		Globals.combo += 1
		hp -= 0.8 + Globals.atkmult
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
	if area.is_in_group("slash"):
		Globals.combotimer = 60 * 10
		hp -= 0.5 + Globals.atkmult
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
	if area.is_in_group("hit2"):
		Globals.combotimer = 60 * 10
		hp -=  1 + Globals.atkmult
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
		
	if area.is_in_group("hit3"):
		Globals.combotimer = 60 * 10
		hp -= 0.4 + Globals.atkmult
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$multihurt.start()
		$multihurtrepeat.start()
		$hurt.play()

		
		
	if area.is_in_group("airhit"):
		hp -= 1 + Globals.atkmult
		Globals.combotimer = 60 * 10
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		frameFreezenonlethal(0, 0.2)
#		$multihurt.start()
#		$multihurtrepeat.start()
		$hurt.play()

	if area.is_in_group("BIGDAMAGE"):
		Globals.combotimer = 60 * 10
		hp -= 3 + Globals.atkmult
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		frameFreezenonlethal(0, 0.2)
		$hurt.play()
